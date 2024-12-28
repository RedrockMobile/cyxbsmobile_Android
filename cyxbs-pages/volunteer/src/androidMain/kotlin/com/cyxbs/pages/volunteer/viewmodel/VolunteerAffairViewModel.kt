package com.cyxbs.pages.volunteer.viewmodel

import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.pages.volunteer.bean.VolunteerAffair
import com.cyxbs.pages.volunteer.network.ApiService
import com.mredrock.cyxbs.common.utils.extensions.mapOrThrowApiException
import com.mredrock.cyxbs.common.utils.extensions.setSchedulers
import com.mredrock.cyxbs.common.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel

/**
 * Created by yyfbe, Date on 2020/9/5.
 */
class VolunteerAffairViewModel : BaseViewModel() {

    val volunteerAffairs = MutableLiveData<List<VolunteerAffair>>()

    fun getVolunteerAffair() {
        ApiGenerator.getApiService(ApiService::class.java)
                .getVolunteerAffair()
                .setSchedulers()
                .mapOrThrowApiException()
                .unsafeSubscribeBy {
                    volunteerAffairs.value = it
                }
    }
}