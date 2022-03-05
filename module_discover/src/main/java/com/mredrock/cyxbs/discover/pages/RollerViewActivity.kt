package com.mredrock.cyxbs.discover.pages

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.hardware.*
import android.media.MediaScannerConnection
import android.os.*
import android.view.KeyEvent
import android.view.KeyEvent.KEYCODE_BACK
import android.view.ViewGroup
import android.webkit.*
import android.widget.Toast
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import com.mredrock.cyxbs.common.component.CyxbsToast
import com.mredrock.cyxbs.common.BuildConfig
import com.mredrock.cyxbs.common.config.DIR_PHOTO
import com.mredrock.cyxbs.common.ui.BaseActivity
import com.mredrock.cyxbs.common.utils.extensions.*
import com.mredrock.cyxbs.common.webView.IAndroidWebView
import com.mredrock.cyxbs.common.webView.LiteJsWebView
import com.mredrock.cyxbs.discover.R
import com.mredrock.cyxbs.discover.network.RollerViewInfo
import com.mredrock.cyxbs.common.webView.WebViewBaseCallBack
import com.mredrock.cyxbs.discover.pages.discover.webView.WebViewFactory

class RollerViewActivity : BaseActivity() {

    private val mWebView by R.id.discover_web_view.view<LiteJsWebView>()

    private val handler = object : Handler(Looper.getMainLooper()) {
        override fun handleMessage(msg: Message) {
            super.handleMessage(msg)
            if (msg.what == 0) {
                //因为保存图片需要权限,WebView类没有持有的权限
                savePic(msg.obj as String)
            }
        }
    }

    //这里是拿到衍生的Web方法类
    private var webApi:IAndroidWebView ? = null

    private val callback: WebViewBaseCallBack ? = webApi

    //传感器(方便remove)
    private val sm: SensorManager? = null
    private var sensorEventListeners: ArrayList<SensorEventListener>? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.discover_activity_roller_view)
        setTheme(R.style.Theme_MaterialComponents) //这里是用的Material主题
        //如果是DEBUG就开启webview的debug
        if (BuildConfig.DEBUG) WebView.setWebContentsDebuggingEnabled(true)

        val url = intent.getStringExtra("URL")

        webApi = WebViewFactory(url,handler, {
            //这里是调用的Js的传进来的Js代码
            mWebView.post {
                mWebView.evaluateJavascript(it) { }
            }
        },
            {
                CyxbsToast.makeText(this, it, Toast.LENGTH_SHORT).show()
            }).produce()

        webApi?.apply {
            mWebView.init(this)
        }
        //加载网页
        mWebView.loadUrl(url)
        //设置几个webview的监听
        mWebView.webChromeClient = object : WebChromeClient() {
            //加载的时候会拿到网页的标签页名字
            override fun onReceivedTitle(view: WebView?, title: String) {
                //拿到web的标题，并设置,可以判断是否使用后端下发的标题
                if (title != "") {
                    common_toolbar.init(title)
                } else {
                    common_toolbar.init(intent.getStringExtra("Key"))
                }
                super.onReceivedTitle(view, title)
            }
        }
        mWebView.webViewClient = object : WebViewClient() {
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return super.shouldOverrideUrlLoading(view, url)
            }

            //这里是页面加载完之后调用
            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                //在加载完之后，获得js中init中调用的方法
                //这里需要Js代码中初始化，否则无法启动
                initBgm()
                initSensor()
            }
        }
        //长按处理各种信息
        mWebView.setOnLongClickListener { view ->
            val result = (view as WebView).hitTestResult
            val type = result.type

            if (type == WebView.HitTestResult.UNKNOWN_TYPE) return@setOnLongClickListener false
            when (type) {
                WebView.HitTestResult.IMAGE_TYPE -> {
                    val imgUrl = result.extra
                }
            }
            true
        }

    }

    private fun initBgm() {
        //使用Web端传入的js命令
        mWebView.post {
            mWebView.evaluateJavascript(webApi?.onLoadStr) { }
        }
    }

    /**
     * 这里是传感器
     * 通过 window.accelerometer(int1,int2,int3)
     * 和window.gyroscope(int1,int2,int3)
     * 把他传出去
     */
    private fun initSensor() {
        //如果没有就退出
        if (webApi?.sensorIDs?.size == 0) return
        val sm = getSystemService(SENSOR_SERVICE) as SensorManager
        sensorEventListeners = ArrayList()
        webApi?.sensorIDs?.forEach {
            when (it) {
                Sensor.TYPE_GYROSCOPE -> {
                    val gyroscope = sm.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
                    gyroscope?.also { gyroscope ->
                        val value = object : SensorEventListener {
                            override fun onSensorChanged(event: SensorEvent) {
                                //调用Js代码，把参数传过去
                                mWebView.evaluateJavascript("window.gyroscope('${event.values[0]}','${event.values[1]}','${event.values[2]}')") {

                                }
                            }

                            override fun onAccuracyChanged(p0: Sensor?, p1: Int) {

                            }
                        }
                        sm.registerListener(value, gyroscope, SensorManager.SENSOR_DELAY_NORMAL)
                        sensorEventListeners?.add(value)
                    }
                }
                Sensor.TYPE_ACCELEROMETER -> {
                    val accelerometer = sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
                    accelerometer?.also { accelerometer ->
                        val value = object : SensorEventListener {
                            override fun onSensorChanged(event: SensorEvent) {
                                //调用Js代码，把参数传过去
                                mWebView.evaluateJavascript("window.accelerometer('${event.values[0]}','${event.values[1]}','${event.values[2]}')") {
                                }
                            }

                            override fun onAccuracyChanged(p0: Sensor?, p1: Int) {}
                        }
                        sm.registerListener(value, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
                        sensorEventListeners?.add(value)
                    }
                }
            }
        }
    }

    private fun savePic(url: String) {
        doPermissionAction(Manifest.permission.WRITE_EXTERNAL_STORAGE) {
            doAfterGranted {
                MaterialAlertDialogBuilder(this@RollerViewActivity)
                    .setTitle(getString(R.string.discover_pic_save_alert_dialog_title))
                    .setMessage(R.string.discover_pic_save_alert_dialog_message)
                    .setPositiveButton("确定") { dialog, _ ->
                        val name = System.currentTimeMillis()
                            .toString() + url.split('/').lastIndex.toString()
                        this@RollerViewActivity.loadBitmap(url) {
                            this@RollerViewActivity.saveImage(it, name)
                            MediaScannerConnection.scanFile(
                                this@RollerViewActivity,
                                arrayOf(
                                    Environment.getExternalStorageDirectory()
                                        .toString() + DIR_PHOTO
                                ),
                                arrayOf("image/jpeg"),
                                null
                            )
                            runOnUiThread {
                                toast("图片保存于系统\"$DIR_PHOTO\"文件夹下哦")
                                dialog.dismiss()
                            }
                        }
                    }
                    .setNegativeButton("取消") { dialog, _ ->
                        dialog.dismiss()
                    }
                    .show()
            }
        }
    }

    //处理返回键，如果是还有历史记录就直接在webView返回
    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KEYCODE_BACK && mWebView.canGoBack()) {
            mWebView.goBack()
            return true
        }
        return super.onKeyDown(keyCode, event)
    }

    override fun onResume() {
        super.onResume()
        mWebView.resumeTimers()
        callback?.webViewResume()
    }

    override fun onPause() {
        callback?.webViewPause()
        //为什么不用webView的onPause(),因为pauseTimers()停止更加强硬，避免出现无法预料的问题
        mWebView.pauseTimers()
        if (sensorEventListeners?.size != 0) {
            sensorEventListeners?.forEach {
                sm?.unregisterListener(it)
            }
        }
        super.onPause()
    }

    override fun onDestroy() {
        callback?.webViewDestroy()
        mWebView.destroy()
        super.onDestroy()
    }

    companion object {
        fun startRollerViewActivity(info: RollerViewInfo, context: Context) {
            context.startActivity<RollerViewActivity>(
                "URL" to info.picture_goto_url,
                "Key" to info.keyword
            )
        }
    }
}