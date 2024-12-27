package com.cyxbs.pages.discover.network

import com.cyxbs.pages.discover.API_ROLLER_VIEW
import com.cyxbs.pages.discover.bean.ItineraryMsgBean
import com.cyxbs.pages.discover.bean.NewsListItem
import com.cyxbs.pages.discover.bean.UfieldMsgBean
import com.cyxbs.pages.discover.bean.UnreadData
import com.cyxbs.components.utils.network.ApiWrapper
import io.reactivex.rxjava3.core.Observable
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by zxzhu
 *   2018/9/7.
 *   enjoy it !!
 */
interface ApiServices {

    @GET(API_ROLLER_VIEW)
    fun getRollerViewInfo(): Observable<ApiWrapper<List<RollerViewInfo>>>

    @GET("/magipoke-jwzx/jwNews/list")
    fun getNewsList(@Query("page") page: Int): Observable<ApiWrapper<List<NewsListItem>>>

    /**
     * 是否有未读信息
     */
    @GET("/message-system/user/msgHasRead")
    fun getHashUnreadMsg() : Observable<ApiWrapper<UnreadData>>

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