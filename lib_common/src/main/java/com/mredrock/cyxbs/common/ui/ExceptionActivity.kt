package com.mredrock.cyxbs.common.ui

import android.content.*
import android.graphics.Color
import android.os.Bundle
import android.os.Process
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.ForegroundColorSpan
import android.text.style.TypefaceSpan
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.mredrock.cyxbs.common.utils.extensions.appendln
import com.mredrock.cyxbs.common.utils.extensions.intentFor
import kotlin.system.exitProcess


/**
 * 调试用的异常activity，此activity不要继承BaseActivity
 */
class ExceptionActivity : AppCompatActivity() {
    companion object {
        const val STACK_INFO = "stack_info"
        const val DEVICE_INFO = "device_info"

        fun start(context: Context, stackInfo: String, deviceInfo: String) {
            val intent = context.intentFor<ExceptionActivity>(STACK_INFO to stackInfo, DEVICE_INFO to deviceInfo)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            context.startActivity(intent)
        }
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val stackInfo = intent.getStringExtra(STACK_INFO)
        val deviceInfo = intent.getStringExtra(DEVICE_INFO)

        val sb = SpannableStringBuilder().apply {
            appendln("StackInfo:", ForegroundColorSpan(Color.parseColor("#FF0006")))
            appendln(stackInfo)
            appendln("deviceInfo:", ForegroundColorSpan(Color.parseColor("#FF0006")))
            appendln(deviceInfo)
            setSpan(TypefaceSpan("monospace"), 0, length, Spanned.SPAN_INCLUSIVE_INCLUSIVE)
        }
        AlertDialog.Builder(this).apply {
            setMessage(sb)
            setTitle("哦豁，掌上重邮崩溃了！")
            setNegativeButton("复制异常信息退出") { _: DialogInterface, i: Int ->
                val message = "StackInfo:\n$stackInfo\ndeviceInfo:\n$deviceInfo"
                val cm = this@ExceptionActivity.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
                cm.primaryClip = ClipData.newPlainText("exception trace stack", message)
                this@ExceptionActivity.finish()
                Process.killProcess(Process.myPid())
                exitProcess(1)
            }
            setCancelable(false)
            setFinishOnTouchOutside(false)
        }.show()

    }
}