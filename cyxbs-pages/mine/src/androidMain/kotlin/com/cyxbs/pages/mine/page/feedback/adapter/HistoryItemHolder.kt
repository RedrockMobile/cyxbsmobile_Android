package com.cyxbs.pages.mine.page.feedback.adapter

import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.color
import com.cyxbs.components.utils.extensions.drawable
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.history.list.bean.History
import com.cyxbs.pages.mine.page.feedback.utils.DateUtils
import com.cyxbs.pages.mine.page.feedback.widget.RightTopPointButton

/**
 *@author ZhiQiang Tu
 *@time 2021/8/24  10:43
 *@signature 我们不明前路，却已在路上
 */
class HistoryItemHolder(
    itemView: View,
    val itemClick: (position: Int) -> Unit
) : RecyclerView.ViewHolder(itemView) {

    private val tvTitle = itemView.findViewById<TextView>(R.id.tv_title)
    private val tvDate = itemView.findViewById<TextView>(R.id.tv_date)
    private val tvReplyOrNot = itemView.findViewById<RightTopPointButton>(R.id.tv_reply_state)

    init {
        itemView.setOnSingleClickListener {
            itemClick.invoke(bindingAdapterPosition)
            tvReplyOrNot.pointVisible = false
        }
    }

    fun bind(history: History) {
        tvTitle.text = history.title
        tvDate.text = DateUtils.longToDate("yyyy/MM/dd HH:mm", history.date)
        tvReplyOrNot.text = if (history.replyOrNot) "已回复" else "未回复"
        BindingAdapters.stateColor(
            tvReplyOrNot,
            history.replyOrNot,
            R.color.mine_feedback_history_list_not_reply_bg_color.color,
            R.color.mine_feedback_recycle_item_text_color.color,
        )
        BindingAdapters.stateView(
            tvReplyOrNot,
            history.replyOrNot,
            R.drawable.mine_shape_feedback_bg_round_not_reply.drawable,
            R.drawable.mine_shape_feedback_bg_round_reply.drawable,
        )
        tvReplyOrNot.pointVisible = history.replyOrNot && !history.isRead
    }
}