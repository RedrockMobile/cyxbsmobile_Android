package com.cyxbs.pages.home.network

import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.components.utils.network.IApi
import com.cyxbs.pages.home.bean.ItineraryMsgBean
import com.cyxbs.pages.home.bean.UfieldMsgBean
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * ...
 * @author: Black-skyline (Hu Shujun)
 * @email: 2031649401@qq.com
 * @date: 2023/9/5
 * @Description: 获取消息中心的消息
 *
 */
interface NotificationApiService : IApi {
    // 获取notification模块中的活动通知消息
    @GET("/magipoke-ufield/message/list/")
    suspend fun getUFieldActivityList(): ApiWrapper<List<UfieldMsgBean>>

    // 获取notification模块中的发送的行程
    @GET("/magipoke-jwzx/itinerary/allMsg")
    suspend fun getSentItinerary(@Query("typ") type: String = "sent"): ApiWrapper<List<ItineraryMsgBean>?>

    // 获取notification模块中的接收的行程
    @GET("/magipoke-jwzx/itinerary/allMsg")
    suspend fun getReceivedItinerary(@Query("typ") type: String = "received"): ApiWrapper<List<ItineraryMsgBean>?>

}