package com.cyxbs.components.utils.extensions

import android.content.Context
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.ProcessLifecycleOwner
import com.cyxbs.components.init.appApplication
import com.cyxbs.components.utils.coroutine.appCoroutineScope

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/5/30 15:57
 */

val appContext: Context
  get() = appApplication.applicationContext

/**
 * 应用程序的生命周期
 *
 * 注意：
 * - ON_START、ON_RESUME 在应用程序进入前台时回调
 * - ON_PAUSE、ON_STOP 在应用程序进入后台时回调
 * - ON_DESTROY 永远不会回调
 *
 * 如果需要使用对应协程作用域，请直接使用 [appCoroutineScope]
 */
val appLifecycle: Lifecycle
  get() = ProcessLifecycleOwner.get().lifecycle
