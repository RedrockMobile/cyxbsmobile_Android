package com.cyxbs.components.utils.extensions

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/3/7 17:58
 */

/**
 * Android：已自带处于其他线程时自动切换至主线程发送
 */
expect fun toast(s: CharSequence?)

expect fun toastLong(s: CharSequence?)

fun String.toast() = toast(this)
fun String.toastLong() = toastLong(this)
