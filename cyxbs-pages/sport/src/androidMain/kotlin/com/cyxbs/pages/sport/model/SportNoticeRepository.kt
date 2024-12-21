package com.cyxbs.pages.sport.model

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
 import com.mredrock.cyxbs.lib.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.lib.utils.network.mapOrInterceptException
import com.cyxbs.pages.sport.model.network.SportNoticeApiService
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers

object SportNoticeRepository {
    init {
        getNoticeInfo()
    }

    private val _noticeData = MutableLiveData<Result<List<NoticeItem>>>()
    val noticeData: LiveData<Result<List<NoticeItem>>> get() = _noticeData

    private fun getNoticeInfo() {
        SportNoticeApiService
            .INSTANCE
            .getSportNotice()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _noticeData.postValue(Result.failure(it))
            }
            .unsafeSubscribeBy {
                _noticeData.postValue(Result.success(it))
            }
    }
}