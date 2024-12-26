package com.cyxbs.components.init

import android.annotation.SuppressLint
import android.app.Activity
import android.app.ActivityManager
import android.app.Application
import android.os.Build
import android.os.Process
import java.lang.ref.WeakReference
import java.util.WeakHashMap

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

/**
 * 所有 activity
 */
val appActivities = WeakHashMap<Activity, Unit>()


/**
 * 当前进程名
 * https://cloud.tencent.com/developer/article/1708529
 */
val appCurrentProcessName: String by lazy {
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
    Application.getProcessName()
  } else {
    try {
      // Android 9 之前无反射限制
      @SuppressLint("PrivateApi")
      val declaredMethod = Class
        .forName("android.app.ActivityThread", false, Application::class.java.classLoader)
        .getDeclaredMethod("currentProcessName")
      declaredMethod.isAccessible = true
      declaredMethod.invoke(null) as String
    } catch (e: Throwable) {
      (appApplication.getSystemService(Application.ACTIVITY_SERVICE) as ActivityManager)
        .runningAppProcesses
        .first {
          it.pid == Process.myPid()
        }.processName
    }
  }
}