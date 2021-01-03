package com.mredrock.cyxbs.qa.pages.dynamic.ui.activity

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.transition.Slide
import android.view.Gravity
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import com.mredrock.cyxbs.common.utils.extensions.setOnSingleClickListener
import com.mredrock.cyxbs.qa.R
import com.mredrock.cyxbs.qa.beannew.Comment
import com.mredrock.cyxbs.qa.component.recycler.RvAdapterWrapper
import com.mredrock.cyxbs.qa.config.CommentConfig
import com.mredrock.cyxbs.qa.config.RequestResultCode
import com.mredrock.cyxbs.qa.pages.dynamic.ui.adapter.ReplyDetailAdapter
import com.mredrock.cyxbs.qa.pages.dynamic.viewmodel.DynamicDetailViewModel
import com.mredrock.cyxbs.qa.ui.adapter.EmptyRvAdapter
import com.mredrock.cyxbs.qa.ui.adapter.FooterRvAdapter
import com.mredrock.cyxbs.qa.ui.widget.OptionalPopWindow
import com.mredrock.cyxbs.qa.ui.widget.QaDialog
import com.mredrock.cyxbs.qa.ui.widget.QaReportDialog
import com.mredrock.cyxbs.qa.utils.ClipboardController
import kotlinx.android.synthetic.main.qa_activity_reply_detail.*
import kotlinx.android.synthetic.main.qa_common_toolbar.*


/**
 *@author zhangzhe
 *@date 2020/12/15
 *@description 复用DynamicDetailViewModel的详细界面
 */

class ReplyDetailActivity : AppCompatActivity() {
    // 要展示的回复的id
    var commentId: String = "-1"

    /**
     * 筛选条件：只显示：昵称或者回复人为
     */
    var replyIdScreen: String? = null

    companion object {
        var viewModel: DynamicDetailViewModel? = null


        fun activityStart(activity: Activity, vm: DynamicDetailViewModel, cId: String, replyIdScreen: String?) {
            activity.apply {
                window.exitTransition = Slide(Gravity.START).apply { duration = 500 }
                startActivityForResult(
                        Intent(this, ReplyDetailActivity::class.java).apply {
                            putExtra("commentId", cId)
                            replyIdScreen?.let { putExtra("replyIdScreen", it) }
                        },
                        RequestResultCode.REPLY_DETAIL_REQUEST
                )
                viewModel = vm
            }
        }
    }

    private val emptyRvAdapter by lazy { EmptyRvAdapter(getString(R.string.qa_comment_list_empty_hint)) }

    private val footerRvAdapter = FooterRvAdapter { refresh() }

    private val replyDetailAdapter = ReplyDetailAdapter(
            onReplyInnerClickEvent = { nickname, commentId ->
                startActivity(Intent(this, DynamicDetailActivity::class.java))
                viewModel?.replyInfo?.value = Pair(nickname, commentId)
            },
            onReplyInnerLongClickEvent = { comment, itemView ->
                val optionPopWindow = OptionalPopWindow.Builder().with(this)
                        .addOptionAndCallback(CommentConfig.REPLY) {
                            viewModel?.replyInfo?.value = Pair(comment.nickName, comment.commentId)
                        }.addOptionAndCallback(CommentConfig.COPY) {
                            ClipboardController.copyText(this, comment.content)
                        }
                if (viewModel?.dynamicLiveData?.value?.isSelf == 1 || comment.isSelf) {
                    optionPopWindow.addOptionAndCallback(CommentConfig.DELETE) {
                        QaDialog.show(this, resources.getString(R.string.qa_dialog_tip_delete_comment_text), {}) {
                            viewModel?.deleteId(comment.commentId, DynamicDetailActivity.COMMENT_DELETE)
                        }
                    }
                } else {
                    optionPopWindow.addOptionAndCallback(CommentConfig.REPORT) {
                        QaReportDialog.show(this) {
                            viewModel?.report(comment.commentId, it, CommentConfig.REPORT_COMMENT_MODEL)
                        }
                    }
                }
                optionPopWindow.show(itemView, OptionalPopWindow.AlignMode.CENTER, 0)
            },
            onReplyMoreDetailClickEvent = { replyIdScreen ->
                activityStart(this, viewModel!!, commentId, replyIdScreen)
            }
    )


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.qa_activity_reply_detail)
        window.enterTransition = Slide(Gravity.END).apply { duration = 500 }
        replyIdScreen = intent.getStringExtra("replyIdScreen")
        commentId = intent.getStringExtra("commentId")

        initToolbar()
        initReplyList()
        initObserver()
    }

    private fun initObserver() {
        /**
         * 从整个评论列表中根据{@param replyId}找到当前评论的回复。
         */
        viewModel?.commentList?.observe(this, Observer { value ->
            var dataList: List<Comment>? = null
            value.forEach {
                if (it.commentId == commentId) {
                    dataList = it.replyList.toMutableList().filter { comment ->
                        if (replyIdScreen.isNullOrEmpty()) {
                            true
                        } else {
                            comment.commentId == replyIdScreen || comment.replyId == replyIdScreen
                        }
                    }.sortedBy { comment ->
                        comment.publishTime
                    }
                }
            }
            dataList?.toMutableList()?.let { replyDetailAdapter.refreshData(it) }
            qa_reply_detail_swipe_refresh.isRefreshing = false
        })
    }

    private fun initReplyList() {

        qa_reply_detail_swipe_refresh.setOnRefreshListener {
            refresh()
        }


        qa_reply_detail_rv_reply_list.apply {
            layoutManager = LinearLayoutManager(context)

            val adapterWrapper = RvAdapterWrapper(
                    normalAdapter = replyDetailAdapter,
                    emptyAdapter = emptyRvAdapter,
                    footerAdapter = footerRvAdapter
            )
            adapter = adapterWrapper
        }
    }
    private fun initToolbar() {
        qa_tv_toolbar_title.text = resources.getText(R.string.qa_reply_detail_title_text)
        qa_ib_toolbar_back.setOnSingleClickListener {
            onBackPressed()
        }
    }


    fun refresh() {
        viewModel?.refreshCommentList(viewModel?.dynamicLiveData?.value?.postId ?: "-1", "-1")
    }
}