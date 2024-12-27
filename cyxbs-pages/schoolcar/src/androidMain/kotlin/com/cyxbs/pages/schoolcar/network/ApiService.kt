package com.cyxbs.pages.schoolcar.network

import com.cyxbs.pages.schoolcar.bean.MapLines
import com.cyxbs.pages.schoolcar.bean.MapLinesVersion
import com.cyxbs.pages.schoolcar.bean.SchoolCarLocation
import com.cyxbs.components.utils.network.ApiWrapper
import io.reactivex.rxjava3.core.Observable
import retrofit2.http.*

/**
 * Created by glossimar on 2018/9/12
 */

interface ApiService {
    @FormUrlEncoded
    @POST("/schoolbus/status")
    fun schoolcar(@Header("Authorization") authorization: String,
                  @Field("s") s: String,
                  @Field("t") t: String,
                  @Field("r") r: String): Observable<ApiWrapper<SchoolCarLocation>>


    //获得校车信息版本号
    @GET("/schoolbus/map/version")
    fun schoolSiteVersion(): Observable<ApiWrapper<MapLinesVersion>>

    //获得地图信息
    @GET("/schoolbus/map/line")
    fun schoolSite(): Observable<ApiWrapper<MapLines>>


}