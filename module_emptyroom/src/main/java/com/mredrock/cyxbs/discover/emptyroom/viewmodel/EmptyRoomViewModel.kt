package com.mredrock.cyxbs.discover.emptyroom.viewmodel

import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.discover.emptyroom.bean.EmptyRoom
import com.mredrock.cyxbs.discover.emptyroom.network.ApiService
import com.mredrock.cyxbs.discover.emptyroom.utils.EmptyConverter
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.extensions.setSchedulers
import com.mredrock.cyxbs.lib.utils.network.ApiGenerator
import io.reactivex.rxjava3.disposables.Disposable
import java.util.concurrent.TimeUnit


/**
 * Created by Cynthia on 2018/9/21
 */

class EmptyRoomViewModel : BaseViewModel() {
    var rooms: MutableLiveData<List<EmptyRoom>> = MutableLiveData()
    var status: MutableLiveData<Int> = MutableLiveData()

    private var d: Disposable? = null

    private val apiService = ApiGenerator.getApiService(ApiService::class.java)

    companion object {
        const val DEFAULT = 1
        const val LOADING = 2
        const val FINISH = 3
        const val ERROR = 4
    }

    init {
        status.value = DEFAULT
    }

    fun getData(week: Int, weekday: Int, building: Int, section: List<Int>) {
        val tag = section.map { it - 1 }//新接口从0开始
            .joinToString(",", " ", " ")
            .replace(" ", "")
        if (section.isEmpty()) {
            status.value = DEFAULT
            return
        }
        status.value = LOADING
        d?.dispose()
        d = apiService.getEmpyRooms(weekday.toString(), tag, building.toString(), week.toString())
            .delay(300, TimeUnit.MILLISECONDS)
            .setSchedulers()
            .safeSubscribeBy(
                onNext = {
                    status.value = FINISH
                    val converter = EmptyConverter()
                    converter.setEmptyData(it.data)
                    rooms.value = converter.convert()
                },
                onError = {
                    status.value = ERROR
                })
    }
}