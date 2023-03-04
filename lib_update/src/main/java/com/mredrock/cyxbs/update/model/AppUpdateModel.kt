package com.mredrock.cyxbs.update.model

import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.api.update.AppUpdateStatus
import com.mredrock.cyxbs.lib.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.lib.utils.network.ApiGenerator
import com.mredrock.cyxbs.lib.utils.network.getBaseUrl
import com.mredrock.cyxbs.lib.utils.utils.get.getAppVersionCode
import com.mredrock.cyxbs.lib.utils.utils.get.getAppVersionName
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import retrofit2.Retrofit
import retrofit2.adapter.rxjava3.RxJava3CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Create By Hosigus at 2020/5/2
 */
object AppUpdateModel {
    
    val APP_VERSION_CODE: Long = getAppVersionCode()
    val status: MutableLiveData<AppUpdateStatus> = MutableLiveData()
    var updateInfo: UpdateInfo? = null
        private set
    
    init {
        status.value = AppUpdateStatus.UNCHECK
    }

    fun checkUpdate() {
        if (status.value == AppUpdateStatus.CHECKING) {
            return
        }
        status.value = AppUpdateStatus.CHECKING
        ApiGenerator.getCommonApiService(AppUpdateApiService::class)
            .getUpdateInfo()
            .onErrorResumeNext {
                getSecondUpdateRetrofit().create(AppUpdateApiService::class.java)
                    .getUpdateInfo()
            }.subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnError {
                status.value = AppUpdateStatus.ERROR
            }.unsafeSubscribeBy {
                updateInfo = it
                status.value = when {
                    it.versionCode == APP_VERSION_CODE -> {
                        val name = getAppVersionName()
                        if (name != it.versionName) {
                            // 名字不相等，说明安装的版本有问题，可能是测试版
                            AppUpdateStatus.DATED
                        } else AppUpdateStatus.VALID
                    }
                    it.versionCode < APP_VERSION_CODE -> {
                        AppUpdateStatus.VALID
                    }
                    else -> AppUpdateStatus.DATED
                }
            }
    }

    /**
     * 当默认域名请求错误
     * 更换备用域名尝试更新
     *
     * 23-2-28：以前是用的上古域名，早就不行了，
     * 从 6.6.1 版本我把他改成了 baseUrl，
     * 但请注意，baseUrl 下并没有对应的更新接口，
     * 如果有必要的话，可以让后端写一个该接口用于更新
     */
    private fun getSecondUpdateRetrofit() = Retrofit.Builder()
        .baseUrl(getBaseUrl())
        .addConverterFactory(GsonConverterFactory.create())
        .addCallAdapterFactory(RxJava3CallAdapterFactory.createSynchronous())
        .build()
}