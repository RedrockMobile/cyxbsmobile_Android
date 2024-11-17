package com.mredrock.cyxbs.protocol.activity

import android.app.ProgressDialog
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import com.mredrock.cyxbs.lib.base.ui.BaseActivity
import com.mredrock.cyxbs.protocol.R


class WebContainerActivity : BaseActivity() {

    companion object {
        const val URI = "uri"
        
        fun loadWebPage(context: Context, uri: String) {
            context.startActivity(Intent(context, WebContainerActivity::class.java).apply {
                putExtra(URI, uri)
            })
        }
    }
    
    private lateinit var mWebView: WebView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val uri = intent.getStringExtra(URI)
        setContentView(R.layout.protocol_activity_web_container)
        mWebView = findViewById(R.id.web_view)
        
        val dialog = ProgressDialog(this)
        dialog.setMessage("加载中...")
        dialog.show()
        
        mWebView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            useWideViewPort = true
            loadWithOverviewMode = true
            setSupportZoom(true)
            builtInZoomControls = true
            displayZoomControls = false
            mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW
            mediaPlaybackRequiresUserGesture = false
            allowFileAccess =false
        }
        mWebView.loadUrl(uri!!)
        mWebView.webChromeClient = object : WebChromeClient() {
            override fun onProgressChanged(view: WebView, newProgress: Int) {
                super.onProgressChanged(view, newProgress)
                if (newProgress >= 100) {
                    dialog.dismiss()
                }
            }
        }
        mWebView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return super.shouldOverrideUrlLoading(view, url)
            }
        }
    }
    
    
    override fun onResume() {
        super.onResume()
        mWebView.resumeTimers()
    }
    
    override fun onPause() {
        super.onPause()
        mWebView.pauseTimers()
    }
    
    
    override fun onDestroy() {
        super.onDestroy()
        mWebView.destroy()
    }
    
}