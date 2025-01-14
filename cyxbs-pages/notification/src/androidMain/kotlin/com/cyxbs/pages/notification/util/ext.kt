package com.cyxbs.pages.notification.util

import android.animation.ValueAnimator
import android.content.Context
import android.content.SharedPreferences
import android.view.Window
import com.cyxbs.pages.notification.util.Constant.NOTIFICATION_SP_FILE_NAME

/**
 * Author by OkAndGreat
 * Date on 2022/4/26 16:13.
 * 扩展函数类
 */

//对Context类的扩展属性
internal val Context.NotificationSp: SharedPreferences
    get() = getSharedPreferences(NOTIFICATION_SP_FILE_NAME, Context.MODE_PRIVATE)

internal fun Window.changeWindowAlpha(targetWindowAlpha: Float) {
    val windowAttrs = attributes
    val curWindowAlpha = windowAttrs.alpha

    val anim = ValueAnimator
        .ofFloat(curWindowAlpha, targetWindowAlpha)
        .setDuration(300)

    anim.addUpdateListener {
        val curVal = it.animatedValue as Float
        windowAttrs.alpha = curVal
        attributes = windowAttrs
    }
    anim.start()
}


