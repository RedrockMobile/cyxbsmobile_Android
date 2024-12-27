package com.cyxbs.pages.ufield.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.setSchedulers
import com.cyxbs.components.utils.network.mapOrThrowApiException
import com.cyxbs.pages.ufield.bean.RankBean
import com.cyxbs.pages.ufield.network.RankService

class RankViewModel : BaseViewModel() {
    private val _rank = MutableLiveData<List<RankBean>>()
    val rank: LiveData<List<RankBean>> get() = _rank
    fun getRank(
        type: String,
        number: Int,
        order: String
    ) {
        RankService.INSTANCE.getRank(type, number, order)
            .setSchedulers()
            .mapOrThrowApiException()
            .doOnError {
                toast("服务君似乎打盹了呢~")
            }.safeSubscribeBy {
                _rank.postValue(it)
            }
    }
}