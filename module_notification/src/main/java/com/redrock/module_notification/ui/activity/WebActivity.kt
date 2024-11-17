package com.redrock.module_notification.ui.activity

import android.content.Context
import android.os.Bundle
import android.widget.RelativeLayout
import com.mredrock.cyxbs.common.ui.BaseActivity
import com.mredrock.cyxbs.common.utils.extensions.startActivity
import com.mredrock.cyxbs.lib.base.webView.LiteJsWebView
import com.redrock.module_notification.R

/**
 * Author by OkAndGreat
 * Date on 2022/5/3 19:24.
 *
 */


class WebActivity : BaseActivity() {
    private val notification_detail_back by R.id.notification_detail_back.view<RelativeLayout>()
    private val notification_wv by R.id.notification_wv.view<LiteJsWebView>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.notification_activity_web)
        val url = intent.getStringExtra("URL")

        notification_detail_back.setOnClickListener { finish() }
        url?.let { notification_wv.loadUrl(it) }

        //必须调用
        notification_wv.init()

    }

    override fun onDestroy() {
        super.onDestroy()
        notification_wv.destroy()
    }

    companion object {
        fun startWebViewActivity(url: String, context: Context) {
            context.startActivity<WebActivity>(
                "URL" to url
            )
        }
    }
}