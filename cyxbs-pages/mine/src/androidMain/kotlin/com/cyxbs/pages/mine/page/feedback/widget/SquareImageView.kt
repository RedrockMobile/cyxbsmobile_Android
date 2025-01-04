package com.cyxbs.pages.mine.page.feedback.widget

import android.content.Context
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatImageView
import kotlin.math.min

/**
 *@author ZhiQiang Tu
 *@time 2021/8/29  8:38
 *@signature 我们不明前路，却已在路上
 */
class SquareImageView @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null
) : AppCompatImageView(context, attrs) {

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        // 因为用的 GridLayoutManager，这里宽度会是 rv 给的固定宽度，所以直接使用宽度即可
        super.onMeasure(widthMeasureSpec, widthMeasureSpec)
    }

}