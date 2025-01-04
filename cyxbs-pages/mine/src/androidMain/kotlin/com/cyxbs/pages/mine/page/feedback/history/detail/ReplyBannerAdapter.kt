package com.cyxbs.pages.mine.page.feedback.history.detail

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.cyxbs.pages.mine.R

/**
 *@author ZhiQiang Tu
 *@time 2021/8/25  16:20
 *@signature 我们不明前路，却已在路上
 */
class ReplyBannerAdapter : ListAdapter<String, ReplyBannerViewHolder>(diff) {

    companion object {
        private val diff = object : DiffUtil.ItemCallback<String>() {
            override fun areItemsTheSame(oldItem: String, newItem: String): Boolean =
                oldItem == newItem

            override fun areContentsTheSame(oldItem: String, newItem: String): Boolean =
                oldItem == newItem

        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ReplyBannerViewHolder {
        return ReplyBannerViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.mine_recycle_item_reply_banner,
                parent, false
            )
        )
    }

    override fun onBindViewHolder(holder: ReplyBannerViewHolder, position: Int) {
        holder.bind(currentList[position])
    }
}

class ReplyBannerViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    private val ivReplyBanner = itemView.findViewById<ImageView>(R.id.iv_reply_banner)

    fun bind(s: String?) {
        Glide.with(ivReplyBanner)
            .load(s)
            .placeholder(R.drawable.mine_ic_feedback_reply_image_holder)
            .skipMemoryCache(true)
            .into(ivReplyBanner)
    }
}