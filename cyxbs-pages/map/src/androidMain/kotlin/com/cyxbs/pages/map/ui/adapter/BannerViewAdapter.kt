package com.cyxbs.pages.map.ui.adapter

import android.content.Context
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.viewpager.widget.PagerAdapter
import com.cyxbs.pages.map.component.RoundRectImageView
import com.cyxbs.components.utils.extensions.setImageFromUrl

class BannerViewAdapter(val context: Context, val mList: MutableList<String>) : PagerAdapter() {


    override fun getCount(): Int {
        if (mList.size == 0) {
            return 0
        }
        if (mList.size > 10) {
            return 10
        }
        return mList.size
    }

    override fun instantiateItem(container: ViewGroup, position: Int): Any {
        val newPosition = position % mList.size
        val roundRectImageView = RoundRectImageView(context)
        roundRectImageView.scaleType = ImageView.ScaleType.CENTER_CROP
        roundRectImageView.setImageFromUrl(mList[newPosition])
        container.addView(roundRectImageView)
        return roundRectImageView
    }

    override fun isViewFromObject(view: View, `object`: Any): Boolean {
        return view == `object`
    }

    override fun destroyItem(container: ViewGroup, position: Int, `object`: Any) {
        container.removeView(`object` as View)
    }

    fun setList(list: List<String>) {
        mList.clear()
        mList.addAll(list)
    }

}