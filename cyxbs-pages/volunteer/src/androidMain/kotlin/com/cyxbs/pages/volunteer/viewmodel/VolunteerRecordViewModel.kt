package com.cyxbs.pages.volunteer.viewmodel

import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.pages.volunteer.bean.VolunteerTime
import com.cyxbs.pages.volunteer.network.ApiService
import com.mredrock.cyxbs.common.utils.extensions.setSchedulers
import com.mredrock.cyxbs.common.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel

/**
 * Created by yyfbe, Date on 2020/9/3.
 */
class VolunteerRecordViewModel : BaseViewModel() {


    val volunteerTime = MutableLiveData<VolunteerTime>()

    fun getVolunteerTime() {
        ApiGenerator.getApiService(ApiService::class.java).getVolunteerRecord()
                .setSchedulers()
                .unsafeSubscribeBy {
                    this.volunteerTime.value = it
                }
    }

    fun unBindAccount() {
        ApiGenerator.getApiService(ApiService::class.java).unbindVolunteerAccount()
                .setSchedulers()
                .unsafeSubscribeBy {
                    //没啥处理，除非后端出问题，没有解绑成功，觉得也并没必要阻止用户重新登录
                }
    }
}