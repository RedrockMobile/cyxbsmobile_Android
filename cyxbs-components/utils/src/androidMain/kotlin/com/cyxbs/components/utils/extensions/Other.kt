package com.cyxbs.components.utils.extensions

import android.content.pm.ApplicationInfo
import android.content.res.Configuration

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/3/7 17:51
 */

/**
 * 不带锁的懒加载，建议使用这个代替 lazy，因为 Android 一般情况下不会遇到多线程问题
 */
fun <T> lazyUnlock(initializer: () -> T) = lazy(LazyThreadSafetyMode.NONE, initializer)

/**
 * 是否是日间模式，否则为夜间模式
 */
fun isDaytimeMode(): Boolean {
  val uiMode = appContext.resources.configuration.uiMode
  return (uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_NO
}

/**
 * 是否是夜间模式
 */
fun isDarkMode() = !isDaytimeMode()

/**
 * 是否是 debug 构建
 */
val isDebuggableBuild: Boolean
  get() = (appContext.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE) != 0



