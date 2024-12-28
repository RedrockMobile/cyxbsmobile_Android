package com.mredrock.cyxbs.common.network

import com.cyxbs.components.utils.network.ApiGenerator
import okhttp3.OkHttpClient
import retrofit2.Retrofit


/**
 * 已被废弃的 lib_common 模块中的网络请求工具类
 *
 * 网络请求的示例代码请看 utils 模块中的 ApiGenerator
 *
 * Created by AceMurder on 2018/1/24.
 */
@Deprecated("使用 utils 模块中的 ApiGenerator 代替", ReplaceWith("com.cyxbs.components.utils.network.ApiGenerator"))
object ApiGenerator {


    fun <T> getApiService(clazz: Class<T>) =
        ApiGenerator.getApiService(clazz)

    fun <T> getCommonApiService(clazz: Class<T>) =
        ApiGenerator.getCommonApiService(clazz)
    /**
     * 通过此方法对得到单独的 Retrofit
     * @param retrofitConfig 配置Retrofit.Builder，已配置有
     * @see GsonConverterFactory
     * @see RxJava3CallAdapterFactory
     * null-> 默认BaseUrl
     * @param okHttpClientConfig 配置OkHttpClient.Builder，已配置有
     * @see HttpLoggingInterceptor
     * null-> 默认Timeout
     * @param tokenNeeded 是否需要添加token请求
     */
    fun createSelfRetrofit(
        tokenNeeded: Boolean,
        retrofitConfig: ((Retrofit.Builder) -> Retrofit.Builder)? = null,
        okHttpClientConfig: ((OkHttpClient.Builder) -> OkHttpClient.Builder)? = null
    ): Retrofit=ApiGenerator.createSelfRetrofit(
      tokenNeeded = tokenNeeded,
      retrofitConfig = retrofitConfig,
      okHttpClientConfig = okHttpClientConfig
    )
}