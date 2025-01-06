package com.cyxbs.components.base.utils

/**
 * Toast 工具类接口
 *
 * ## 为什么不放到 utils 中？
 * 如果放到 utils 中，在值依赖 base 的时候会出现无法继承 BaseActivity 的情况
 *
 * 所以要求 base 类实现的接口尽量不要放在其他模块内
 */
interface ToastUtils {
  /**
   * 已自带处于其他线程时自动切换至主线程发送
   */
  fun toast(s: CharSequence?) {
    com.cyxbs.components.utils.extensions.toast(s)
  }
  fun toastLong(s: CharSequence?) {
    com.cyxbs.components.utils.extensions.toastLong(s)
  }
  fun String.toast() = toast(this)
  fun String.toastLong() = toastLong(this)
}