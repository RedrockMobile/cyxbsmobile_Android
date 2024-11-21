package com.mredrock.cyxbs.sport.model.network

import com.mredrock.cyxbs.lib.utils.network.ApiGenerator
import com.mredrock.cyxbs.lib.utils.network.ApiWrapper
import com.mredrock.cyxbs.sport.model.NoticeItem
import io.reactivex.rxjava3.core.Single
import retrofit2.http.GET

interface SportNoticeApiService {

    companion object {
        val INSTANCE by lazy {
            ApiGenerator.getApiService(SportNoticeApiService::class.java)
        }
    }

    /**
     * 获取体育打卡信息说明
     */
    @GET("/magipoke-sport/notice")
    fun getSportNotice(): Single<ApiWrapper<List<NoticeItem>>>
}