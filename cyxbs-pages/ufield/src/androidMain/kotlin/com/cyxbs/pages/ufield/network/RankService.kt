package com.cyxbs.pages.ufield.network

import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.pages.ufield.bean.MsgBeanData
import com.cyxbs.pages.ufield.bean.RankBean
import io.reactivex.rxjava3.core.Observable
import retrofit2.http.GET
import retrofit2.http.Query

interface RankService {
    companion object {
        val INSTANCE by lazy {
            ApiGenerator.getApiService(RankService::class)
        }
    }

    //获取排行榜里的数据
    @GET("/magipoke-ufield/activity/search")
    fun getRank(
        @Query("activity_type") type: String,
        @Query("activity_num") number: Int,
        @Query("order_by") order: String
    ): Observable<ApiWrapper<List<RankBean>>>

    @GET("/magipoke-ufield/activity/list/me/")
    fun getAllMsg(): Observable<ApiWrapper<MsgBeanData>>
}