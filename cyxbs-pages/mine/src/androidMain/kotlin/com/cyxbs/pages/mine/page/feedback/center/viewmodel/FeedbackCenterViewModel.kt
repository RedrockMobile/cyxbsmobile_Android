package com.cyxbs.pages.mine.page.feedback.center.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.setSchedulers
import com.cyxbs.pages.mine.page.feedback.api
import com.cyxbs.pages.mine.page.feedback.network.bean.NormalFeedback

/**
 * @Date : 2021/8/23   20:57
 * @By ysh
 * @Usage :
 * @Request : God bless my code
 **/
class FeedbackCenterViewModel: BaseViewModel() {
    /**
     * 标题列表
     */
    private val _contentList = MutableLiveData<List<NormalFeedback.Data>>()
    val contentList : LiveData<List<NormalFeedback.Data>>
        get() = _contentList
    fun setContentList(value:List<NormalFeedback.Data>){
        _contentList.value = value
    }

    init {
        api.getNormalFeedback("1")
            .setSchedulers()
            .doOnError {
                toast("网络请求失败")
            }
            .safeSubscribeBy {
                _contentList.value = it.data
            }
    }
}