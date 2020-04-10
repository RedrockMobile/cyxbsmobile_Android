package com.mredrock.cyxbs.qa.pages.question.ui

import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import com.mredrock.cyxbs.common.utils.extensions.setAvatarImageFromUrl
import com.mredrock.cyxbs.qa.R
import com.mredrock.cyxbs.qa.bean.Question
import com.mredrock.cyxbs.qa.component.recycler.BaseEndlessRvAdapter
import com.mredrock.cyxbs.qa.component.recycler.BaseViewHolder
import com.mredrock.cyxbs.qa.utils.questionTimeDescription
import com.mredrock.cyxbs.qa.utils.toDate
import kotlinx.android.synthetic.main.qa_recycler_item_question.view.*

/**
 * Created By jay68 on 2018/8/26.
 */
class QuestionListRvAdapter(private val onItemClickEvent: (Question) -> Unit) : BaseEndlessRvAdapter<Question>(DIFF_CALLBACK) {
    companion object {
        @JvmStatic
        val DIFF_CALLBACK = object : DiffUtil.ItemCallback<Question>() {
            override fun areItemsTheSame(oldItem: Question, newItem: Question) = oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: Question, newItem: Question) = oldItem == newItem
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = QuestionViewHolder(parent)

    override fun onItemClickListener(holder: BaseViewHolder<Question>, position: Int, data: Question) {
        super.onItemClickListener(holder, position, data)
        if (holder !is QuestionViewHolder) return
        onItemClickEvent.invoke(data)
    }

    class QuestionViewHolder(parent: ViewGroup) : BaseViewHolder<Question>(parent, R.layout.qa_recycler_item_question) {
        override fun refresh(data: Question?) {
            data ?: return
            itemView.apply {
                iv_avatar.setAvatarImageFromUrl(data.photoThumbnailSrc)
                tv_nickname.text = data.nickname
                tv_title.text = data.title
                tv_reward_count.text = data.reward.toString()
                tv_answer_count.text = data.answerNum.toString()
                tv_view_count.text = data.viewCount.toString()
                tv_publish_at.text = questionTimeDescription(System.currentTimeMillis(), data.createdAt.toDate().time)

            }
        }

    }
}