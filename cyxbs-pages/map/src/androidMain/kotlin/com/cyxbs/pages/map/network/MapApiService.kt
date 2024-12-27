package com.cyxbs.pages.map.network

import com.cyxbs.pages.map.bean.*
import com.cyxbs.components.utils.network.ApiStatus
import com.cyxbs.components.utils.network.ApiWrapper
import io.reactivex.rxjava3.core.Observable
import okhttp3.MultipartBody
import retrofit2.http.*

/**
 *@author zhangzhe
 *@date 2020/8/8
 *@description 掌邮地图网络请求，需要用getApiService获得而不是getCommonApiService（如果有token）
 */

internal interface MapApiService {
    @GET("/magipoke-stumap/basic")
    fun getMapInfo(): Observable<ApiWrapper<MapInfo>>

    @FormUrlEncoded
    @POST("/magipoke-stumap/detailsite")
    fun getPlaceDetails(@Field("place_id") placeId: String): Observable<ApiWrapper<PlaceDetails>>

    @GET("/magipoke-stumap/button")
    fun getButtonInfo(): Observable<ApiWrapper<ButtonInfo>>

    @FormUrlEncoded
    @POST("/magipoke-stumap/searchtype")
    fun getSearchType(@Field("code") code: String): Observable<ApiWrapper<MutableList<String>>>

    @FormUrlEncoded
    @POST("/magipoke-stumap/addhot")
    fun addHot(@Field("id") placeId: Int): Observable<ApiStatus>

    @GET("/magipoke-stumap/rockmap/collect")
    fun getCollect(): Observable<ApiWrapper<FavoritePlaceSimple>>

    @FormUrlEncoded
    @PATCH("/magipoke-stumap/rockmap/addkeep")
    fun addCollect(@Field("place_id") placeId: String): Observable<ApiStatus>

    @Multipart
    @HTTP(method = "DELETE", path = "/magipoke-stumap/rockmap/deletekeep", hasBody = true)
    fun deleteCollect(@Part("place_id") placeId: Int): Observable<ApiStatus>

    @Multipart
    @POST("/magipoke-stumap/rockmap/upload")
    fun uploadPicture(@Part photo: MultipartBody.Part, @PartMap params: Map<String, Int>): Observable<ApiStatus>

    @FormUrlEncoded
    @POST("/magipoke-stumap/placesearch")
    fun placeSearch(@Field("place_search") placeSearch: String): Observable<ApiWrapper<PlaceSearch>>
}