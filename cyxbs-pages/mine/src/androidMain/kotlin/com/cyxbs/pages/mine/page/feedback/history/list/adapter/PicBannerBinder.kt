package com.cyxbs.pages.mine.page.feedback.history.list.adapter

import android.net.Uri
import android.view.View
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.adapter.rv.RvHolder
import com.cyxbs.pages.mine.page.feedback.widget.RightTopDrawableLayout

/**
 *@author ZhiQiang Tu
 *@time 2021/8/25  0:05
 *@signature 我们不明前路，却已在路上
 */
class PicBannerBinderAdd(
    itemView: View,
    val onAddClick: (() -> Unit)? = null,
) : RvHolder(itemView) {

    private val ivBannerAdd = itemView.findViewById<ImageView>(R.id.iv_banner_add)

    override fun onBind(uri: Uri?) {
        ivBannerAdd.setOnSingleClickListener {
            onAddClick?.invoke()
        }
    }
}

class PicBannerBinderPic(
    itemView: View,
    val onRemoveClick: ((Uri) -> Unit)? = null,
    val onContentClick: ((Uri) -> Unit)? = null,
) : RvHolder(itemView) {

    private var tag: Long = 0

    private val ivBannerPic = itemView.findViewById<ImageView>(R.id.iv_banner_pic)
    private val rtdlBannerPic = itemView.findViewById<RightTopDrawableLayout>(R.id.rtdl_banner_pic)

    override fun onBind(uri: Uri?) {
        uri ?: return
        Glide.with(ivBannerPic)
            .load(uri.toString())
            .into(ivBannerPic)
        rtdlBannerPic.setOnContentClickListener {
            //防止重复点击
            val time = System.currentTimeMillis()
            if (time - tag < 500) return@setOnContentClickListener
            tag = time
            onContentClick?.invoke(uri)
        }

        rtdlBannerPic.setOnIconClickListener {
            //防止重复点击
            val time = System.currentTimeMillis()
            if (time - tag < 500) return@setOnIconClickListener
            tag = time
            onRemoveClick?.invoke(uri)
        }
    }
}
