package com.cyxbs.components.base.crash

import android.os.Looper
import android.os.SystemClock
import android.util.Log
import com.cyxbs.components.base.BuildConfig
import com.cyxbs.components.base.crash.CrashActivity.Companion.NetworkApiResult
import com.cyxbs.components.base.pages.SecretActivity
import io.reactivex.rxjava3.plugins.RxJavaPlugins

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/25
 */
object CrashMonitor {

  // 提供给 application 模块向外暴露异常用于上报
  var crashReport: ((Throwable) -> Unit)? = null

  private var lastThrowableTime = 0L

  fun install() {
    installThreadHandler()
    installRxjavaErrorHandler()
  }

  private fun installThreadHandler() {
    Thread.setDefaultUncaughtExceptionHandler { t, e ->
      if (t === Looper.getMainLooper().thread) {
        if (BuildConfig.DEBUG) {
          Log.d("crash", e.stackTraceToString())
        }
        handleMainThread(t, e)
        crashReport?.invoke(e)
      } else {
        handleOtherThread(t, e)
      }
    }
  }

  private fun installRxjavaErrorHandler() {
    RxJavaPlugins.setErrorHandler {
      if (BuildConfig.DEBUG) throw it
    }
  }

  private fun handleOtherThread(thread: Thread, throwable: Throwable) {
    // 其他线程不处理
  }

  private fun handleMainThread(thread: Thread, throwable: Throwable) {
    CrashDialog.Builder(
      RuntimeException(
        "触发了一次来自主线程的异常, ${throwable.message}",
        throwable
      )
    ).show()
    lastThrowableTime = SystemClock.elapsedRealtime()
    tryLoop(throwable)
  }

  private fun tryLoop(originThrowable: Throwable) {
    // 主线程崩溃后 loop 会停掉，这里重启 loop
    try {
      Looper.loop()
    } catch (e: Exception) {
      e.printStackTrace()
      if (SystemClock.elapsedRealtime() - lastThrowableTime < 1000) {
        // 短时间内再次崩溃，则直接打开 CrashActivity
        CrashActivity.start(
          throwable = originThrowable,
          netWorkApiResults = if (SecretActivity.sSpPandoraIsOpen) {
            // 如果当前用户值得信任，则可以传递 apiResultList
            CrashNetworkConfigService.apiResultList.mapTo(ArrayList()) {
              // 因为 CrashActivity 是在另一个进程中启动，所以只能以 String 的形式传过去
              NetworkApiResult(it.request.toString(), it.response.toString(), it.throwable)
            }
          } else null
        )
      } else {
        CrashDialog.Builder(RuntimeException("触发了一次来自主线程的异常, ${e.message}", e)).show()
        lastThrowableTime = SystemClock.elapsedRealtime()
        tryLoop(e)
      }
    }
  }
}