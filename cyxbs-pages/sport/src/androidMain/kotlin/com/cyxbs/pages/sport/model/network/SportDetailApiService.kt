package com.cyxbs.pages.sport.model.network

import com.mredrock.cyxbs.lib.utils.network.ApiGenerator
import com.mredrock.cyxbs.lib.utils.network.ApiWrapper
import com.cyxbs.pages.sport.model.SportDetailBean
import io.reactivex.rxjava3.core.Single
import retrofit2.http.GET

/**
 * @author : why
 * @time   : 2022/8/5 21:15
 * @bless  : God bless my code
 */
interface SportDetailApiService {
    companion object {
        /**
         * SportDetailApiService的实例
         */
        val INSTANCE by lazy {
            ApiGenerator.getApiService(SportDetailApiService::class.java)
        }
    }

    /**
     * 获取体育打卡详情页面数据
     */
    @GET("/magipoke-sport/sport")
    fun getSportDetailData(): Single<ApiWrapper<SportDetailBean>>
}