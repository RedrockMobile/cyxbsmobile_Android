package com.mredrock.cyxbs.discover.grades.utils.extension

import com.mredrock.cyxbs.lib.utils.extensions.appContext

/**
 * Created by roger on 2020/2/12
 */
fun dp2px(value: Int): Int {
    val v = appContext.resources.displayMetrics.density
    return (v * value + 0.5f).toInt()
}