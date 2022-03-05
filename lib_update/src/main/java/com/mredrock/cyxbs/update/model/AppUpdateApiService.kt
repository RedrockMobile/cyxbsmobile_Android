package com.mredrock.cyxbs.update.model

import io.reactivex.rxjava3.core.Observable
import retrofit2.http.GET

/**
 * Create By Hosigus at 2019/5/11
 */
interface AppUpdateApiService {
    @GET("https://app.redrock.team/cyxbsAppUpdate.json")
    fun getUpdateInfo(): Observable<UpdateInfo>
}