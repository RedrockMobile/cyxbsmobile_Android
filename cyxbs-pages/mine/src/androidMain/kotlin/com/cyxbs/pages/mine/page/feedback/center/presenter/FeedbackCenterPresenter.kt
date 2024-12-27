package com.cyxbs.pages.mine.page.feedback.center.presenter

import com.mredrock.cyxbs.common.utils.extensions.unsafeSubscribeBy
import com.mredrock.cyxbs.common.utils.extensions.setSchedulers
import com.mredrock.cyxbs.common.utils.extensions.toast
import com.cyxbs.pages.mine.base.presenter.BasePresenter
import com.cyxbs.pages.mine.page.feedback.api
import com.cyxbs.pages.mine.page.feedback.center.viewmodel.FeedbackCenterViewModel

/**
 * @Date : 2021/8/23   20:56
 * @By ysh
 * @Usage :
 * @Request : God bless my code
 **/
class FeedbackCenterPresenter :
    BasePresenter<FeedbackCenterViewModel>(), FeedbackCenterContract.IPresenter {
    /**
     * 初始化数据
     */
    override fun fetch() {
        api.getNormalFeedback("1")
            .setSchedulers()
            .doOnSubscribe {}
            .doOnError { }
            .unsafeSubscribeBy(
                onNext = {
                    it?.let {
                        vm?.setContentList(it.data)
                    }
                },
                onError = {
                    toast("网络请求失败")
                },
                onComplete = {
                }
            )
    }
}