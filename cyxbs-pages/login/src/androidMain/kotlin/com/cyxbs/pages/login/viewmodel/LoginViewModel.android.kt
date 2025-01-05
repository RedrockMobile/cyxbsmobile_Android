package com.cyxbs.pages.login.viewmodel

import android.os.SystemClock
import com.cyxbs.components.account.api.IAccountService
import com.cyxbs.components.base.BaseApp
import com.cyxbs.components.utils.coroutine.runCatchingCoroutine
import com.cyxbs.components.utils.service.impl
import com.cyxbs.components.utils.utils.judge.NetworkUtil
import com.cyxbs.pages.login.bean.DeviceInfoParams
import com.cyxbs.pages.login.network.LoginApiService
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.withContext
import retrofit2.HttpException
import java.io.IOException
import kotlin.time.Duration.Companion.milliseconds
import kotlin.time.Duration.Companion.seconds

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
actual class LoginViewModel : CommonLoginViewModel() {

  private val _event = MutableSharedFlow<Event>()
  val event: SharedFlow<Event> get() = _event

  // 后端服务是否可用
  private var mIsServerAvailable = true

  init {
    launch {
      NetworkUtil.tryPingNetWork()?.onFailure {
        mIsServerAvailable = false
      }
    }
  }

  override suspend fun login() {
    _event.emit(Event.HideSoftInput)
    if (!mIsServerAvailable) {
      toast("当前后端服务不可用，可能无法正常登录")
    }
    val startTime = SystemClock.elapsedRealtime().milliseconds
    runCatchingCoroutine {
      withContext(Dispatchers.IO) {
        IAccountService::class.impl()
          .getVerifyService()
          .login(appContext, username.value, password.value)
      }
    }.also {
      // 网络太快会闪一下，像bug，就让它最少待两秒吧
      delay(2.seconds + startTime - SystemClock.elapsedRealtime().milliseconds)
    }.onFailure {
      when (it) {
        is IOException -> toast("网络中断，请检查您的网络状态") // Retrofit 对于网络无法连接将抛出 IOException
        is HttpException -> toast("登录服务暂时不可用")
        is IllegalStateException -> when (it.message) {
          "tried too many times" -> toast("登录过于频繁，请15分钟后再试")
          "authentication error" -> toast("登录失败：学号或者密码错误,请检查输入")
          "Internet error" -> toast("尚未注册，账号是学号，初始密码是统一验证码后六位")
        }
        else -> toast(it.message)
      }
    }.onFailure {
      _event.emit(Event.Login(false))
    }.onSuccess {
      _event.emit(Event.Login(true))
    }.onSuccess {
      postDeviceInfo()
    }
  }

  override fun clickForgetPassword() {
    launch {
      _event.emit(Event.ClickForgetPassword)
    }
  }

  override fun clickUserAgreement() {
    launch {
      _event.emit(Event.ClickUserAgreement)
    }
  }

  override fun clickPrivacyPolicy() {
    launch {
      _event.emit(Event.ClickPrivacyPolicy)
    }
  }

  override fun enterTouristMode() {
    launch {
      _event.emit(Event.Login(null))
    }
  }

  override fun clickDisagreeUserAgreement() {
    launch {
      _event.emit(Event.ClickDisagreeUserAgreement)
    }
  }

  private fun postDeviceInfo() {
    /**
     * 登录后向后端发送一次登录时的设备信息以及wifi的ip（如果连接了wifi并且能获取到）
     * 如果连接方式为流量或者无法获取到wifi的ip，则直接上传 null 即可
     */
    var ipAddress: String? = null
    //检测网络的连接方式
    NetworkUtil.checkCurrentNetworkType()?.let {
      //如果是通过wifi连接，则尝试获取wifi的ip
      if (!it) {
        ipAddress = NetworkUtil.getWifiIPAddress()
      }
    }
    launch {
      //上传设备以及ip信息
      LoginApiService.INSTANCE.recordDeviceInfo(
        DeviceInfoParams(
          BaseApp.getAndroidID(),
          BaseApp.getDeviceModel(),
          ipAddress
        )
      )
    }
  }

  /**
   * 登录界面所有事件收口处
   */
  sealed interface Event {
    data object HideSoftInput: Event
    data class Login(val result: Boolean?) : Event
    data object ClickForgetPassword : Event
    data object ClickUserAgreement : Event
    data object ClickPrivacyPolicy : Event
    data object ClickDisagreeUserAgreement : Event
  }
}