package com.cyxbs.pages.mine.page.feedback.adapter.rv

import android.net.Uri
import android.view.View
import androidx.recyclerview.widget.RecyclerView

/**
 *@author ZhiQiang Tu
 *@time 2021/8/11  11:20
 *@signature 我们不明前路，却已在路上
 */
abstract class RvHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    abstract fun onBind(uri: Uri?)
}