package com.mredrock.cyxbs.electricity.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.electricity.bean.ElecInf
import com.mredrock.cyxbs.electricity.network.ApiService
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.extensions.setSchedulers
import com.mredrock.cyxbs.lib.utils.network.ApiGenerator
import com.mredrock.cyxbs.lib.utils.network.throwApiExceptionIfFail
import kotlinx.coroutines.flow.MutableSharedFlow

/**
 * Author: Hosigus
 * Date: 2018/9/28 19:30
 * Description: com.mredrock.cyxbs.electricity.viewmodel
 */
class ChargeViewModel : BaseViewModel() {
    val chargeInfo: LiveData<ElecInf> = MutableLiveData()
    val loadFailed = MutableSharedFlow<Boolean>()

    private val service: ApiService by lazy {
        ApiGenerator.getApiService(ApiService::class.java)
    }

    fun getCharge(building: String, room: String) {
        service.getElectricityInfo(building, room)
            .throwApiExceptionIfFail()
            .map {
                it.elecInf
            }
            .setSchedulers()
            .safeSubscribeBy {
                (chargeInfo as MutableLiveData).value = it
            }
    }

    fun preGetCharge() {
        service.getElectricityInfo()
            .throwApiExceptionIfFail()
            .map {
                it.elecInf
            }
            .setSchedulers()
            .doOnError {
                launch {
                    loadFailed.emit(true)
                }
            }
            .safeSubscribeBy {
                if (it == null) {
                    launch {
                        loadFailed.emit(true)
                    }
                }
                (chargeInfo as MutableLiveData).value = it
            }
    }

}