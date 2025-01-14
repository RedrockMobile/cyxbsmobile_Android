package com.cyxbs.pages.schoolcar.network

import io.reactivex.rxjava3.core.Observable
import okhttp3.ResponseBody
import retrofit2.http.GET
import retrofit2.http.Path

interface MapService {
    @GET("/magipoke-text/data/{type}")
    fun getMapRes(@Path("type")type:String): Observable<ResponseBody>
}