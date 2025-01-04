package com.cyxbs.pages.mine.page.feedback.history.detail

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.base.ui.viewModelBy
import com.cyxbs.components.utils.extensions.drawable
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.adapter.BindingAdapters
import com.cyxbs.pages.mine.page.feedback.utils.DateUtils

class HistoryDetailActivity : BaseActivity() {

    private val viewModel by viewModelBy {
        HistoryDetailViewModel(intent.getLongExtra("historyId",-1L))
    }

    /**
     * rv_recycle的Adapter
     */
    private val replyBannerRvAdapter by lazy {
        ReplyBannerAdapter()
    }

    private val tvDate by R.id.tv_date.view<TextView>()
    private val rvReplyBanner by R.id.rv_reply_banner.view<RecyclerView>()
    private val btnBack by R.id.btn_back.view<View>()
    private val tvTitle by R.id.tv_title.view<TextView>()
    private val tvFeedbackTitle by R.id.tv_feedback_title.view<TextView>()
    private val tvContent by R.id.tv_content.view<TextView>()
    private val clImagesLayout by R.id.cl_images_layout.view<View>()
    private val ivFeedbackPic1 by R.id.iv_feedback_pic_1.view<ImageView>()
    private val ivFeedbackPic2 by R.id.iv_feedback_pic_2.view<ImageView>()
    private val ivFeedbackPic3 by R.id.iv_feedback_pic_3.view<ImageView>()
    private val tvFeedbackLabel by R.id.tv_feedback_label.view<TextView>()
    private val tvReplyDate by R.id.tv_reply_date.view<TextView>()
    private val cvReply by R.id.cv_reply.view<View>()
    private val tvReplyContent by R.id.tv_reply_content.view<TextView>()
    private val ivNoneReply by R.id.iv_none_reply.view<ImageView>()
    private val tvNoneReply by R.id.tv_none_reply.view<TextView>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mine_activity_history_detail)
        initView()
        initListener()
        observeData()
    }

    /**
     * 初始化View和View的一些配置项
     */
    private fun initView() {
        /**
         * 设置rv_recycle
         */
        rvReplyBanner.apply {
            adapter = replyBannerRvAdapter
            layoutManager = GridLayoutManager(this@HistoryDetailActivity, 3)
        }

        tvTitle.text = resources.getString(R.string.mine_feedback_center_history_icon)
    }

    private fun initListener() {
        btnBack.setOnSingleClickListener {
            finish()
        }
    }

    /**
     * 观察vm中的数据变动
     */
    @SuppressLint("SetTextI18n")
    private fun observeData() {
        viewModel.feedback.observe { feedback ->
            tvDate.text = DateUtils.longToDate("yyyy/MM/dd HH:mm", feedback.date)
            tvFeedbackTitle.text = feedback.title
            tvContent.text = feedback.content
            clImagesLayout.visibility = if (feedback.urls.isNotEmpty()) View.VISIBLE else View.GONE
            feedback.urls.getOrNull(0)?.let {
                BindingAdapters.netImage(ivFeedbackPic1, it, R.drawable.mine_ic_feedback_feedback_image_holder.drawable)
            }
            feedback.urls.getOrNull(1)?.let {
                BindingAdapters.netImage(ivFeedbackPic2, it, R.drawable.mine_ic_feedback_feedback_image_holder.drawable)
            }
            feedback.urls.getOrNull(2)?.let {
                BindingAdapters.netImage(ivFeedbackPic3, it, R.drawable.mine_ic_feedback_feedback_image_holder.drawable)
            }
            tvFeedbackLabel.text = "#${feedback.label}"

        }
        viewModel.reply.observe {
            tvReplyDate.text = DateUtils.longToDate("yyyy/MM/dd HH:mm", it.date)
            tvReplyContent.text = "回复：${it.content}"
            replyBannerRvAdapter.submitList(it.bannerPics)
        }
        viewModel.isReply.observe {
            tvReplyDate.visibility = if (it) View.VISIBLE else View.GONE
            cvReply.visibility = if (it) View.VISIBLE else View.GONE
            ivNoneReply.visibility = if (it) View.GONE else View.VISIBLE
            tvNoneReply.visibility = if (it) View.GONE else View.VISIBLE
        }
    }
}