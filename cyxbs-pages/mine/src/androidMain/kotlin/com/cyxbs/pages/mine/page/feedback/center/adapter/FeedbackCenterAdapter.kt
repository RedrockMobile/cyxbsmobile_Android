package com.cyxbs.pages.mine.page.feedback.center.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.center.ui.FeedbackCenterActivity
import com.cyxbs.pages.mine.page.feedback.network.bean.NormalFeedback

/**
 * @Date : 2021/8/24   18:27
 * @By ysh
 * @Usage :
 * @Request : God bless my code
 **/
class FeedbackCenterAdapter : RecyclerView.Adapter<FeedbackCenterAdapter.InnerViewHolder>() {

    private var eventHandler:FeedbackCenterActivity.EventHandler?=null

    private val mContentList by lazy {
        mutableListOf<NormalFeedback.Data>()
    }

    inner class InnerViewHolder(itemView:View):RecyclerView.ViewHolder(itemView) {
        val title = itemView.findViewById<TextView>(R.id.tv_center_title)

        init {
          itemView.setOnSingleClickListener {
              eventHandler?.onItemClick(it, mContentList[bindingAdapterPosition].title, mContentList[bindingAdapterPosition].content)
          }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): InnerViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(
                R.layout.mine_item_question,
                parent,
                false
        )
        return InnerViewHolder(view)
    }

    override fun onBindViewHolder(holder: InnerViewHolder, position: Int) {
        holder.title.text = mContentList[position].title
    }

    override fun getItemCount(): Int {
        return mContentList.size
    }

    fun setData(contentList:List<NormalFeedback.Data>){
        mContentList.clear()
        mContentList.addAll(contentList)

        notifyDataSetChanged()
    }

    fun setEventHandler(eventHandler:FeedbackCenterActivity.EventHandler){
        this.eventHandler = eventHandler
    }
}