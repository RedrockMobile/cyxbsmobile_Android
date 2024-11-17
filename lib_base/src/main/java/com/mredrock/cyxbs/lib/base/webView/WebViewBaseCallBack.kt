package com.mredrock.cyxbs.lib.base.webView


/**
 * 回调函数可以自行增加，因为没有具体的需求所以说没有写
 */
interface WebViewBaseCallBack {

    //webViewResume后
    fun webViewResume()

    //webViewPause前
    fun webViewPause()

    //webViewDestroy前
    fun webViewDestroy()
}