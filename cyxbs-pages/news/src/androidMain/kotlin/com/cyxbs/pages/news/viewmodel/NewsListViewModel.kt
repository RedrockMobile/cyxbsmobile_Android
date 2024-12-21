package com.cyxbs.pages.news.viewmodel

import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.common.network.ApiGenerator
import com.mredrock.cyxbs.common.utils.extensions.mapOrThrowApiException
import com.mredrock.cyxbs.common.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.common.utils.extensions.setSchedulers
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import com.cyxbs.pages.news.bean.NewsListItem
import com.cyxbs.pages.news.network.ApiService

/**
 * Create By Hosigus at 2019/4/30
 */
class NewsListViewModel : BaseViewModel() {

    val newsEvent = MutableLiveData<List<NewsListItem>>()

    private var nextPage = 1

    fun loadNewsData() {
        ApiGenerator.getApiService(ApiService::class.java)
                .getNewsList(nextPage++)
                .mapOrThrowApiException()
                .setSchedulers()
                .unsafeSubscribeBy {
                    newsEvent.postValue(it)
                }.lifeCycle()
    }

    fun clearPages() {
        nextPage = 1
    }
}