package com.cyxbs.pages.mine.page.feedback.center.presenter

import com.cyxbs.pages.mine.page.feedback.network.bean.NormalFeedback

/**
 * @Date : 2021/8/23   21:03
 * @By ysh
 * @Usage :
 * @Request : God bless my code
 **/
interface FeedbackCenterContract {

    interface IPresenter {

    }

    interface IVM {
        fun setContentList(value:List<NormalFeedback.Data>)
    }
}