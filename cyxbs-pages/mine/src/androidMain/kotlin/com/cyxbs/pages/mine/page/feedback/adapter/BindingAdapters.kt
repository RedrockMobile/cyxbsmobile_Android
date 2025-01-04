package com.cyxbs.pages.mine.page.feedback.adapter

import android.graphics.drawable.Drawable
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.ColorInt
import com.bumptech.glide.Glide

object BindingAdapters {
    fun stateView(
        view: View?,
        state: Boolean?,
        backgroundFalse: Drawable?,
        backgroundTrue: Drawable?
    ) {
        if (state == null) return
        if (state) {
            view?.background = backgroundTrue
        } else {
            view?.background = backgroundFalse
        }
    }

    fun netImage(
        imageView: ImageView, url: String?,
        placeholder: Drawable?,
    ) {
        url ?: return
        if (!url.matches(Regex("http.+"))) return
        Glide.with(imageView.context)
            .load(url)
            .placeholder(placeholder)
            .skipMemoryCache(true)
            .into(imageView)
    }

    fun stateColor(
        textView: TextView?,
        stateColor: Boolean?,
        @ColorInt colorFalse: Int?,
        @ColorInt colorTrue: Int?
    ) {
        textView ?: return
        stateColor ?: return
        if (stateColor == false) {
            colorFalse?.let { textView.setTextColor(it) }
        } else {
            colorTrue?.let { textView.setTextColor(it) }
        }

    }

}