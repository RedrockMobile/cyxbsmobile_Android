package com.mredrock.cyxbs.lib.base.webView

import android.os.Handler
import androidx.annotation.Keep


/**
 * 如果是要暴露给js调用的接口 请加上 [@JavascriptInterface] 注释
 */
@Keep
class AndroidWebView(
    handler: Handler? = null,
    exe: (String) -> Unit = {},
    toast: (String) -> Unit = {}
) : IAndroidWebView(handler, exe, toast) {


    override fun webViewResume() {

    }

    override fun webViewPause() {

    }

    override fun webViewDestroy() {

    }


}