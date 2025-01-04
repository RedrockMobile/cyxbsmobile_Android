package com.cyxbs.pages.mine.page.feedback.adapter.rv

import android.net.Uri
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.history.list.adapter.PicBannerBinderAdd
import com.cyxbs.pages.mine.page.feedback.history.list.adapter.PicBannerBinderPic

/**
 *@author ZhiQiang Tu
 *@time 2021/8/11  11:19
 *@signature 我们不明前路，却已在路上
 */
class RvAdapter(
    val onAddClick: (() -> Unit)? = null,
    val onRemoveClick: ((Uri) -> Unit)? = null,
    val onContentClick: ((Uri) -> Unit)? = null,
) : ListAdapter<Uri?, RvHolder>(diff) {

    companion object {
        private val diff = object : DiffUtil.ItemCallback<Uri?>() {
            override fun areItemsTheSame(oldItem: Uri, newItem: Uri): Boolean = oldItem == newItem

            // areItemsTheSame 返回 true 时才会回调 areContentsTheSame，这里直接返回 true 即可
            override fun areContentsTheSame(oldItem: Uri, newItem: Uri): Boolean = true
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RvHolder {
        val view = LayoutInflater.from(parent.context).inflate(viewType, parent, false)
        return if (viewType == R.layout.mine_recycle_item_banner_add) {
            PicBannerBinderAdd(view, onAddClick)
        } else PicBannerBinderPic(view, onRemoveClick, onContentClick)
    }

    override fun onBindViewHolder(holder: RvHolder, position: Int) {
        holder.onBind(currentList[position])
    }

    override fun submitList(list: MutableList<Uri?>?) {
        super.submitList(list)
    }

    override fun getItemViewType(position: Int): Int = if (currentList[position] == null) {
        R.layout.mine_recycle_item_banner_add
    } else {
        R.layout.mine_recycle_item_banner_pic
    }
}

