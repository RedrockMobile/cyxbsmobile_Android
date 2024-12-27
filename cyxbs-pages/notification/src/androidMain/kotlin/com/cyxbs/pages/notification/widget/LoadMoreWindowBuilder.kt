package com.cyxbs.pages.notification.widget

import android.content.Context
import android.view.Window
import androidx.annotation.LayoutRes
import com.cyxbs.components.utils.extensions.dp2px
import kotlin.properties.Delegates

/**
 * Author by OkAndGreat
 * Date on 2022/5/17 23:04.
 * 使用DSL方式构建LoadMoreWindow
 */
fun buildLoadMoreWindow(init: (LoadMoreWindowBuilder.() -> Unit)): LoadMoreWindow {
    val builder = LoadMoreWindowBuilder()
    builder.init()
    return builder.build()
}

class LoadMoreWindowBuilder {
    var context by Delegates.notNull<Context>()
    var window by Delegates.notNull<Window>()

    @LayoutRes
    var layoutRes: Int = 0

    var Width: Int = 0
    var Height: Int = 0

    fun build(): LoadMoreWindow {
        if (Width == 0) Width = 120.dp2px
        if (Height == 0) Height = 120.dp2px
        return LoadMoreWindow(context, layoutRes, window, Width, Height)
    }
}