package com.cyxbs.pages.login.network

import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.ApiStatus
import com.cyxbs.pages.login.bean.DeviceInfoParams
import io.reactivex.rxjava3.core.Single
import retrofit2.http.Body
import retrofit2.http.POST

/**
 * @author : why
 * @time   : 2023/4/1 11:19
 * @bless  : God bless my code
 */
interface LoginApiService {
    companion object {
        val INSTANCE by lazy {
            ApiGenerator.getApiService(LoginApiService::class)
        }
    }

    /**
     * 登录时上传设备信息以及wifi的ip地址
     */
    @POST("/magipoke/token/record")
    fun recordDeviceInfo(@Body deviceInfoParams: DeviceInfoParams):Single<ApiStatus>
}