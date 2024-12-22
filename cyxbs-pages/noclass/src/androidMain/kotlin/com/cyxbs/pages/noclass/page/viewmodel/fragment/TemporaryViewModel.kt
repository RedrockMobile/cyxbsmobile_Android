package com.cyxbs.pages.noclass.page.viewmodel.fragment

import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.network.ApiWrapper
import com.cyxbs.pages.noclass.bean.Cls
import com.cyxbs.pages.noclass.bean.NoClassGroup
import com.cyxbs.pages.noclass.bean.NoClassTemporarySearch
import com.cyxbs.pages.noclass.page.repository.NoClassRepository

class TemporaryViewModel : BaseViewModel() {

    private val _searchAll = MutableLiveData<ApiWrapper<NoClassTemporarySearch>>()
    val searchAll get() = _searchAll

    //临时分组页面搜索全部
    fun getSearchAllResult(content: String) {
        NoClassRepository.searchAll(content)
            .doOnError {
                _searchAll.postValue(ApiWrapper(NoClassTemporarySearch(Cls("", listOf(),""),
                    NoClassGroup("",false, listOf(),""), listOf(), listOf()
                ),50000,"net error"))
            }
            .safeSubscribeBy {
                _searchAll.postValue(it)
            }
    }
}