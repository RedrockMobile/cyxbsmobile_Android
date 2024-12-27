package com.cyxbs.pages.sport.model.network

import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.pages.sport.model.NoticeItem
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