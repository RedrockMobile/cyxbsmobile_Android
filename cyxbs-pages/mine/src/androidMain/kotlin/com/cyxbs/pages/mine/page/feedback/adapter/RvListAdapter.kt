package com.cyxbs.pages.mine.page.feedback.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.history.list.bean.History

/**
 *@author ZhiQiang Tu
 *@time 2021/8/24  10:42
 *@signature 我们不明前路，却已在路上
 */
class RvListAdapter : ListAdapter<History, HistoryItemHolder>(diff) {

    private var itemClickListener: ItemClickListener? = null

    companion object {
        private val diff = object : DiffUtil.ItemCallback<History>() {
            override fun areItemsTheSame(oldItem: History, newItem: History): Boolean =
                oldItem.id == newItem.id


            override fun areContentsTheSame(oldItem: History, newItem: History): Boolean =
                oldItem == newItem

        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): HistoryItemHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.mine_feedback_recycle_item_detail, parent, false)
        return HistoryItemHolder(view) {
            itemClickListener?.clicked(currentList[it])
        }
    }

    override fun onBindViewHolder(holder: HistoryItemHolder, position: Int) {
        holder.bind(currentList[position])
    }

    fun setOnItemClickListener(listener: ItemClickListener) {
        this.itemClickListener = listener
    }

    interface ItemClickListener {
        fun clicked(data: History)
    }

}