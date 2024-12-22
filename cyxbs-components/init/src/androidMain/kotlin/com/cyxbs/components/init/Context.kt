package com.cyxbs.components.init

import android.app.Activity
import android.app.Application
import java.lang.ref.WeakReference

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/22
 */

lateinit var appApplication: Application

/**
 * 获取栈顶的 Activity
 *
 * 栈顶 Activity 可用于实现全局 dialog
 */
lateinit var appTopActivity: WeakReference<Activity>