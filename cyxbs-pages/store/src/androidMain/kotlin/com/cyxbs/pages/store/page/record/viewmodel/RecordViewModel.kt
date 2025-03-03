package com.cyxbs.pages.store.page.record.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.network.api
import com.cyxbs.components.utils.network.mapOrInterceptException
import com.cyxbs.pages.store.bean.ExchangeRecord
import com.cyxbs.pages.store.bean.StampGetRecord
import com.cyxbs.pages.store.network.ApiService
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 *    author : zz
 *    e-mail : 1140143252@qq.com
 *    date   : 2021/8/2 14:47
 */
class RecordViewModel : BaseViewModel() {
    // 兑换记录
    private val _exchangeRecord = MutableLiveData<List<ExchangeRecord>>()
    val exchangeRecord: LiveData<List<ExchangeRecord>>
        get() = _exchangeRecord
    
    // 兑换记录请求是否成功（状态）
    private val _exchangeRecordIsSuccessfulState = MutableLiveData<Boolean>()
    val exchangeRecordIsSuccessfulState: LiveData<Boolean>
        get() = _exchangeRecordIsSuccessfulState
    // 兑换记录请求是否成功（事件）
    val exchangeRecordIsSuccessfulEvent = _exchangeRecordIsSuccessfulState.asShareFlow()

    // 获取记录
    private val _pageStampGetRecord = MutableLiveData<List<StampGetRecord>>()
    val pageStampGetRecord: LiveData<List<StampGetRecord>>
        get() = _pageStampGetRecord
    
    // 第一页获取记录请求是否成功（状态）
    private val _firstPageGetRecordIsSuccessfulState = MutableLiveData<Boolean>()
    val firstPageGetRecordIsSuccessfulState: LiveData<Boolean>
        get() = _firstPageGetRecordIsSuccessfulState
    // 第一页获取记录请求是否成功（事件）
    val firstPageGetRecordIsSuccessfulEvent = _exchangeRecordIsSuccessfulState.asShareFlow()
    
    // 下一页获取记录请求是否成功（状态）
    private val _nestPageGetRecordIsSuccessfulState = MutableLiveData<Boolean>()
    val nestPageGetRecordIsSuccessfulState: LiveData<Boolean>
        get() = _nestPageGetRecordIsSuccessfulState
    // 下一页获取记录请求是否成功（事件）
    val nestPageGetRecordIsSuccessfulEvent = _nestPageGetRecordIsSuccessfulState.asShareFlow()
    
    init {
        getExchangeRecord()
        getFirstPageGetRecord()
    }

    private fun getExchangeRecord() {
        ApiService::class.api
            .getExchangeRecord()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _exchangeRecordIsSuccessfulState.postValue(false)
            }.safeSubscribeBy {
                _exchangeRecordIsSuccessfulState.postValue(true)
                _exchangeRecord.postValue(it)
            }
    }

    private var nowPage = 1
    private fun getFirstPageGetRecord() {
        ApiService::class.api
            .getStampGetRecord(1, 30)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _firstPageGetRecordIsSuccessfulState.postValue(false)
            }.safeSubscribeBy {
                _firstPageGetRecordIsSuccessfulState.postValue(true)
                _pageStampGetRecord.postValue(it)
            }
    }

    fun getNextPageGetRecord() {
        ApiService::class.api
            .getStampGetRecord(nowPage + 1, 30)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _nestPageGetRecordIsSuccessfulState.postValue(false)
            }.safeSubscribeBy {
                _nestPageGetRecordIsSuccessfulState.postValue(true)
                if (it.isNotEmpty()) {
                    val oldList = pageStampGetRecord.value ?: emptyList()
                    _pageStampGetRecord.postValue(
                        oldList.toMutableList()
                            .apply { addAll(it) }
                    )
                }
            }
    }
}