package com.cyxbs.pages.news.viewmodel

import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.news.bean.NewsListItem
import com.cyxbs.pages.news.network.ApiService
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.mapOrThrowApiException
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 * Create By Hosigus at 2019/4/30
 */
class NewsListViewModel : BaseViewModel() {

    val newsEvent = MutableLiveData<List<NewsListItem>>()

    private var nextPage = 1

    fun loadNewsData() {
        ApiGenerator.getApiService(ApiService::class.java)
                .getNewsList(nextPage++)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .mapOrThrowApiException()
                .safeSubscribeBy {
                    newsEvent.postValue(it)
                }
    }

    fun clearPages() {
        nextPage = 1
    }
}