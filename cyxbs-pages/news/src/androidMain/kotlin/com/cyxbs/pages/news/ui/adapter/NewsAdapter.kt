package com.cyxbs.pages.news.ui.adapter

import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.cyxbs.pages.news.R
import com.cyxbs.pages.news.bean.NewsListItem
import com.cyxbs.pages.news.ui.activity.NewsItemActivity
import com.cyxbs.pages.news.utils.TimeFormatHelper
import com.mredrock.cyxbs.lib.utils.extensions.lazyUnlock
import com.mredrock.cyxbs.lib.utils.extensions.setOnSingleClickListener


/**
 * Author: Hosigus
 * Date: 2018/9/20 15:23
 * Description: com.mredrock.cyxbs.discover.news.ui.adapter
 */
const val NORMAL_TYPE = 0x1
const val FOOT_TYPE = 0x2

class NewsAdapter(private val loadMore: () -> Unit)
    : androidx.recyclerview.widget.RecyclerView.Adapter<NewsAdapter.ViewHolder>() {

    private val newsList: MutableList<NewsListItem> = mutableListOf()

    init {
        loadMore()
    }

    fun appendNewsList(newList: List<NewsListItem>) {
        newsList.addAll(newList)
        notifyItemRangeInserted(newsList.size, newList.size)
    }

    fun clear() {
        newsList.clear()
        notifyDataSetChanged()
    }

    override fun getItemViewType(position: Int) = if (position == newsList.size) FOOT_TYPE else NORMAL_TYPE

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = if (viewType == FOOT_TYPE) {
        FootHolder(LayoutInflater.from(parent.context).inflate(R.layout.news_item_footer,parent,false))
    } else {

        ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.news_item_news, parent, false))
    }

    override fun getItemCount():Int {
        return if(newsList.size!=0)
            newsList.size + 1
        else
            0
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) = holder.initView(
            if (getItemViewType(position) == FOOT_TYPE) {
                null
            } else {
                newsList[position]
            }
    )

    open inner class ViewHolder(v: View) : androidx.recyclerview.widget.RecyclerView.ViewHolder(v) {
    
        val tv_time:TextView by lazyUnlock {
            v.findViewById(R.id.tv_time)
        }
        val tv_title:TextView by lazyUnlock {
            v.findViewById(R.id.tv_title)
        }
        
        fun initView(news: NewsListItem?) {
            itemView.init(news)
        }

        protected open fun View.init(news: NewsListItem?) {
            news ?: return
            setOnSingleClickListener {
                context.startActivity(
                    Intent(context, NewsItemActivity::class.java)
                        .putExtra("id", news.id)
                        .putExtra("title", news.title)
                )
            }
            tv_time.text = TimeFormatHelper.format(news.date)
            tv_title.text = news.title
        }
    }

    inner class FootHolder(v: View) : ViewHolder(v) {
        override fun View.init(news: NewsListItem?) {
            loadMore()
        }
    }
}