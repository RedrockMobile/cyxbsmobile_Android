package com.cyxbs.pages.electricity.network

import com.cyxbs.pages.electricity.bean.ElectricityInfo
import io.reactivex.rxjava3.core.Observable
import retrofit2.http.Field
import retrofit2.http.FormUrlEncoded
import retrofit2.http.POST

/**
 * Author: Hosigus
 * Date: 2018/9/18 1:12
 * Description: com.cyxbs.pages.electricity.network
 */
interface ApiService {
    @FormUrlEncoded
    @POST("/magipoke-elecquery/getElectric")
    fun getElectricityInfo(@Field("building") building: String, @Field("room") room: String): Observable<ElectricityInfo>


    @POST("/magipoke-elecquery/getElectric")
    fun getElectricityInfo(): Observable<ElectricityInfo>
}