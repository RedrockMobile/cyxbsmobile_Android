package com.cyxbs.components.account

import android.content.Context
import androidx.annotation.MainThread
import androidx.annotation.WorkerThread
import androidx.core.content.edit
import com.afollestad.materialdialogs.MaterialDialog
import com.alibaba.android.arouter.facade.annotation.Route
import com.cyxbs.components.account.api.ACCOUNT_SERVICE
import com.cyxbs.components.account.api.IAccountService
import com.cyxbs.components.account.api.IUserService
import com.cyxbs.components.account.api.IUserStateService
import com.cyxbs.components.account.api.IUserTokenService
import com.cyxbs.components.account.bean.LoginParams
import com.cyxbs.components.account.bean.RefreshParams
import com.cyxbs.components.account.bean.TokenWrapper
import com.cyxbs.components.utils.utils.secret.Secret
import com.cyxbs.components.utils.extensions.Value
import com.cyxbs.components.account.bean.ErrorMsg
import com.cyxbs.components.account.bean.UserInfo
import com.cyxbs.pages.login.api.ILoginService
import com.cyxbs.components.config.sp.defaultSp
import com.cyxbs.components.utils.extensions.GsonDefault
import com.cyxbs.components.utils.extensions.toast
import com.cyxbs.components.utils.network.ApiException
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.components.utils.service.impl
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.subjects.BehaviorSubject
import io.reactivex.rxjava3.subjects.PublishSubject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.HttpException
import retrofit2.Response

/**
 * Created By jay68 on 2019-11-12.
 */
@Route(path = ACCOUNT_SERVICE, name = ACCOUNT_SERVICE)
internal class AccountService : IAccountService {

    private val mUserService: IUserService = UserService()
    private val mUserStateService: IUserStateService = UserStateService()
    private val mUserTokenSerVice: IUserTokenService = UserTokenSerVice()
    private val mUserInfoEncryption = Secret()

    private var user: UserInfo? = null
    @Volatile
    private var tokenWrapper: TokenWrapper? = null
    private var isTouristMode = false
    private lateinit var mContext: Context
    override fun init(context: Context) {
        this.mContext = context
        (mUserStateService as UserStateService).loginFromCache(context)
        isTouristMode = defaultSp.getBoolean(SP_IS_TOURIST, false)
    }

    override fun getUserService() = mUserService

    override fun getVerifyService() = mUserStateService

    override fun getUserTokenService(): IUserTokenService = mUserTokenSerVice

    private fun bind(tokenWrapper: TokenWrapper) {
        //如果接口出问题，token or refreshToken为空就不要他被覆盖，以免出现未知的问题
        if(tokenWrapper.isEmptyData()){
            return
        }
        this.tokenWrapper = tokenWrapper
        //每次刷新存储到本地
        defaultSp.edit {
            putString(
                SP_KEY_USER_V2,
                mUserInfoEncryption.encrypt(GsonDefault.toJson(tokenWrapper))
            )
        }
        //每次刷新的时候拿token请求一次个人信息，覆盖原来的
        ApiGenerator.getCommonApiService(ApiService::class)
            .getUserInfo("Bearer ${tokenWrapper.token}")
            .enqueue(object: Callback<ApiWrapper<UserInfo>> {
                override fun onResponse(
                    call: Call<ApiWrapper<UserInfo>>,
                    response: Response<ApiWrapper<UserInfo>>
                ) {
                    val userInfo = response.body()?.data //如果为空就不更新
                    userInfo?.let {
                        defaultSp.edit(commit = true) {
                            putString(SP_KEY_USER_INFO, mUserInfoEncryption.encrypt(GsonDefault.toJson(userInfo)))
                        }
                        this@AccountService.user = userInfo
                        // 通知 StuNum 更新
                        (mUserService as UserService).emitStuNum(it.stuNum)
                    }
                }

                override fun onFailure(call: Call<ApiWrapper<UserInfo>>, t: Throwable) {
                    toast("个人信息无法更新")
                }
            })
    }

    inner class UserService : IUserService {
        override fun getUsername(): String = user?.username.orEmpty()

        override fun getStuNum() = user?.stuNum.orEmpty()

        override fun getAvatarImgUrl() = user?.photoSrc.orEmpty()

        override fun getGender() = user?.gender.orEmpty()

        override fun getCollege() = user?.college.orEmpty()

        //用于刷新个人信息，请在需要的地方调用
        override fun refreshInfo() {
            tokenWrapper?.let { bind(it) }
        }
        
        // 发送学号给下游
        fun emitStuNum(stuNum: String?) {
            val value = stuNum ?: ""
            stuNumState.onNext(value)
            stuNumEvent.onNext(value)
        }
    
        private val stuNumState = BehaviorSubject.create<String>()
        private val stuNumEvent = PublishSubject.create<String>()
    
        override fun observeStuNumState(): Observable<String> {
            return stuNumState.distinctUntilChanged()
        }
    
        override fun observeStuNumEvent(): Observable<String> {
            return stuNumEvent.distinctUntilChanged()
        }
    }

    inner class UserStateService : IUserStateService {
        
        private val userStateState = BehaviorSubject.create<IUserStateService.UserState>()
        private val userStateEvent = PublishSubject.create<IUserStateService.UserState>()
    
        override fun observeUserStateState(): Observable<IUserStateService.UserState> {
            return userStateState.distinctUntilChanged()
        }
        override fun observeUserStateEvent(): Observable<IUserStateService.UserState> {
            return userStateEvent.distinctUntilChanged()
        }

        private fun notifyAllStateListeners(state: IUserStateService.UserState) {
            userStateState.onNext(state)
            userStateEvent.onNext(state)
        }

        override fun isLogin() = tokenWrapper != null

        override fun isTouristMode(): Boolean = isTouristMode

        override fun isExpired(): Boolean {
            if (!isLogin()) {
                return true
            }
            val curTime = System.currentTimeMillis()
            val expiredTime = defaultSp.getLong(SP_KEY_TOKEN_EXPIRED, 0)
            //预留10s，防止一些奇怪的错误出现
            return curTime - expiredTime >= 10000L
        }

        override fun isRefreshTokenExpired(): Boolean {
            val curTime = System.currentTimeMillis()
            val expiredTime =
                defaultSp.getLong(SP_KEY_REFRESH_TOKEN_EXPIRED, 0)
            //当前时间比预期过期时间快10s，就过期了
            return curTime - expiredTime >= 10000L
        }

        fun loginFromCache(context: Context) {
            val encryptedTokenJson = defaultSp.getString(SP_KEY_USER_V2, null) ?: ""
            val userInfo = defaultSp.getString(SP_KEY_USER_INFO, "")
            userInfo?.let {
                user = GsonDefault
                    .fromJson(mUserInfoEncryption.decrypt(userInfo), UserInfo::class.java)
                // 这里是从本地拿取数据，是第一次通知 StuNum 更新
                (mUserService as UserService).emitStuNum(user?.stuNum)
            }
            tokenWrapper = TokenWrapper.fromJson(
                mUserInfoEncryption.decrypt(
                    encryptedTokenJson
                )
            )
            val state = when {
                isLogin() -> IUserStateService.UserState.LOGIN
                else -> IUserStateService.UserState.NOT_LOGIN
            }
            notifyAllStateListeners(state)
        }

        @WorkerThread
        override fun refresh() {
            val refreshToken = tokenWrapper?.refreshToken ?: error("refreshToken初始值为空，请尝试重新登录")
            val response = ApiGenerator.getCommonApiService(ApiService::class)
                .refresh(RefreshParams(refreshToken),mUserService.getStuNum()).execute()
            val body = response.body()
            if (body != null) {
                // 根据后端标准返回文档：https://redrock.feishu.cn/wiki/wikcnB9p6U45ZJZmxwTEu8QXvye
                if (body.status == 20004) {
                    toast("用户认证刷新失败，请重新登录")
                    // 直接将 refreshToken 过期时间清零，用户下次打开就会直接跳转至重新登录
                    defaultSp.edit(commit = true) { putLong(SP_KEY_REFRESH_TOKEN_EXPIRED, 0) }
                    error("用户认证刷新失败，请重新登录！")
                }
            } else error("用户认证刷新失败，请尝试重新登录\nhttp code = ${response.code()}")
            body.data.let { data ->
                bind(data)
                isTouristMode = false
                defaultSp.edit(commit = true) {
                    putBoolean(SP_IS_TOURIST, isTouristMode)
                }
                defaultSp.edit(commit = true) {
                    putLong(
                        SP_KEY_REFRESH_TOKEN_EXPIRED,
                        System.currentTimeMillis() + SP_REFRESH_DAY
                    )
                    putLong(
                        SP_KEY_TOKEN_EXPIRED,
                        System.currentTimeMillis() + SP_TOKEN_TIME
                    )
                }
                notifyAllStateListeners(IUserStateService.UserState.REFRESH)
            }
        }


        @MainThread
        override fun askLogin(context: Context, reason: String) {
            if (isLogin()) {
                return
            }

            MaterialDialog(context).show {
                title(R.string.account_whether_login)
                message(text = reason)
                positiveButton(R.string.account_login_now) {
                    if (!isLogin()) {
                        ILoginService::class.impl
                            .startLoginActivityReboot()
                    }
                }
                negativeButton(R.string.account_login_later) {
                    dismiss()
                }
                cornerRadius(16F)
            }

        }

        /**
         * 登录
         * @throws IllegalStateException
         */
        @WorkerThread
        override fun login(context: Context, uid: String, passwd: String) {
            val response = ApiGenerator.getCommonApiService(ApiService::class)
                .login(LoginParams(uid, passwd)).execute()
            //不同情况给用户不同的提示
            if (response.code() == 400) {
                // 22年 后端有 "student info fail" 和 "sign in failed" 两种状态，但我们直接给学号或者密码错误即可
                // 该异常已与下游约定，不可更改！！！
                //请求失败目前分两种 40004为次数过多，20004为账号密码错误，返回值需json解析
                val errorBody = response.errorBody()?.string()
                val errorMsg:ErrorMsg? = GsonDefault.fromJson(errorBody, ErrorMsg::class.java)
                if (errorMsg != null) {
                    when (errorMsg.status) {
                        40004 -> throw IllegalStateException("tried too many times")
                        20004 -> throw IllegalStateException("authentication error")
                    }
                    when (errorMsg.errcode){
                        10010 -> throw IllegalStateException("Internet error")
                    }
                }
                throw IllegalStateException("authentication error")
            }
            if (response.body() == null) {
                throw HttpException(response)
            }
            val apiWrapper = response.body()
            //该字段涉及到Java的反射，kotlin的机制无法完全保证不为空，需要判断一下
            if (apiWrapper?.data != null) {
                bind(apiWrapper.data)
                isTouristMode = false
                defaultSp.edit(commit = true) {
                    putBoolean(SP_IS_TOURIST, isTouristMode)
                }
                defaultSp.edit(commit = true) {
                    putString(
                        SP_KEY_USER_V2,
                        mUserInfoEncryption.encrypt(GsonDefault.toJson(apiWrapper.data))
                    )
                    putLong(
                        SP_KEY_REFRESH_TOKEN_EXPIRED,
                        System.currentTimeMillis() + SP_REFRESH_DAY
                    )
                    putLong(
                        SP_KEY_TOKEN_EXPIRED,
                        System.currentTimeMillis() + SP_TOKEN_TIME
                    )
                }
                notifyAllStateListeners(IUserStateService.UserState.LOGIN)
            } else {
                apiWrapper?.apply {
                    throw ApiException(status, info)
                }
            }
        }

        override fun logout(context: Context) {
            defaultSp.edit(commit = true) {
                putString(SP_KEY_USER_V2, "")
                putString(SP_KEY_USER_INFO, "")
                putLong(SP_KEY_REFRESH_TOKEN_EXPIRED, 0)
                putLong(SP_KEY_TOKEN_EXPIRED, 0)
            }
            user = null
            // 通知 StuNum 更新
            (mUserService as UserService).emitStuNum(null)
            tokenWrapper = null
            notifyAllStateListeners(IUserStateService.UserState.NOT_LOGIN)
        }

        //游客模式
        override fun loginByTourist() {
            isTouristMode = true
            defaultSp.edit(commit = true) {
                putBoolean(SP_IS_TOURIST, isTouristMode)
            }
            notifyAllStateListeners(IUserStateService.UserState.TOURIST)
        }
    }

    inner class UserTokenSerVice : IUserTokenService {
        override fun getRefreshToken(): String {
            return tokenWrapper?.refreshToken ?: ""
        }

        override fun getToken(): String {
            return tokenWrapper?.token ?: ""
        }

        override fun refreshTokenExpired() {
            defaultSp.edit(commit = true) {
                putLong(SP_KEY_REFRESH_TOKEN_EXPIRED, 0)
            }
        }

        override fun tokenExpired() {
            defaultSp.edit(commit = true) {
                putLong(SP_KEY_TOKEN_EXPIRED, 0)
            }
        }
    }
    
    companion object {
        // 是否是游客模式
        const val SP_IS_TOURIST = "is_tourist"
    
        //UserToken信息存储key
        const val SP_KEY_USER_V2 = "cyxbsmobile_user_v2"
    
        //User信息存储key
        const val SP_KEY_USER_INFO = "cyxbsmobile_user_info"
    
        //token失效时间
        const val SP_KEY_TOKEN_EXPIRED = "user_token_expired_time"
    
        //token 后端规定token2h过期，客户端规定1h55分过期，以防错误，时间戳
        const val SP_TOKEN_TIME = 6900000
    
        //refreshToken失效时间
        const val SP_KEY_REFRESH_TOKEN_EXPIRED = "user_refresh_token_expired_time"
    
        //refreshToken 后端规定45天过期，客户端规定44天过期，以防错误，时间戳
        const val SP_REFRESH_DAY = 3801600000
    }
}