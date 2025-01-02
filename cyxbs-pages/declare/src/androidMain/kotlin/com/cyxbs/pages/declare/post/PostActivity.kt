package com.cyxbs.pages.declare.post

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.text.InputFilter.LengthFilter
import android.view.LayoutInflater
import android.view.View
import android.widget.EditText
import androidx.activity.viewModels
import androidx.appcompat.widget.AppCompatButton
import androidx.core.widget.addTextChangedListener
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.afollestad.materialdialogs.MaterialDialog
import com.afollestad.materialdialogs.customview.customView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.dp2px
import com.cyxbs.pages.declare.R
import com.cyxbs.pages.declare.post.adapter.PostSectionRvAdapter
import com.google.android.material.textfield.TextInputEditText
import com.google.android.material.textfield.TextInputLayout
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume

class PostActivity : BaseActivity() {

    override val isCancelStatusBar: Boolean
        get() = false

    private val viewModel by viewModels<PostViewModel>()
    private lateinit var submitDialogManager: SubmitDialogManager
    private lateinit var editDialogManager: EditDialogManager
    private lateinit var sectionAdapter: PostSectionRvAdapter

    private val rvTopic by R.id.rv_topic.view<RecyclerView>()
    private val pageBtnSubmit by R.id.btn_submit.view<AppCompatButton>()
    private val etTopic by R.id.et_topic.view<TextInputEditText>()
    private val declareIvToolbarArrowLeft by R.id.declare_iv_toolbar_arrow_left.view<View>()

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.declare_activity_post)
        setSupportActionBar(findViewById(R.id.toolbar))
        supportActionBar?.title = null
        initDialog()
        rvTopic.apply {
            layoutManager = LinearLayoutManager(this@PostActivity)
            adapter = PostSectionRvAdapter(
                onItemTouch = { list, position, et ->
                    lifecycleScope.launch {
                        // 长度限制15
                        openEdit(15, list[position])?.let {
                            if (list.any { s -> it == s }) {
                                toast("不允许存在多个相同的选项哦")
                                return@let
                            }
                            et.setText(it)
                            list[position] = it
                            // 更新主页按钮状态
                            pageBtnSubmit.active()
                        }
                    }
                },
                onItemUpdate = { pageBtnSubmit.active() }
            ).also { sectionAdapter = it }
        }
        pageBtnSubmit.setOnClickListener {
            if (isPublishable()) {
                // 弹出Dialog
                submitDialogManager.dialog.show()
            }
        }
        etTopic.setOnClickListener {
            lifecycleScope.launch {
                openEdit(30, etTopic.text.toString())?.let {
                    etTopic.setText(it)
                    pageBtnSubmit.active()
                }
            }
        }
        etTopic.isFocusable = false
        declareIvToolbarArrowLeft.setOnClickListener {
            finish()
        }
        lifecycleScope.launch {
            viewModel.postResultFlow.collectLaunch {
                if (it == null) {
                    toast("发布成功")
                    finish()
                } else {
                    toast("发布失败 $it")
                }
            }
        }
    }

    private fun initDialog() {
        submitDialogManager = SubmitDialogManager()
        editDialogManager = EditDialogManager()

        submitDialogManager.btnCancel.setOnClickListener {
            submitDialogManager.dialog.hide()
        }
        submitDialogManager.btnSubmit.setOnClickListener {
            lifecycleScope.launch {
                // 空白选项不能发
                viewModel.post(etTopic.text.toString(), sectionAdapter.list)
            }
            submitDialogManager.dialog.hide()
        }
    }

    private suspend fun openEdit(maxLen: Int, originText: String = ""): String? = suspendCancellableCoroutine  { co ->
        editDialogManager.apply {
            // 重置edittext状态
            et.setText(originText)
            et.filters = arrayOf(LengthFilter(maxLen))
            textInputLayout.counterMaxLength = maxLen
            btnSubmit.active(et.text.toString().isNotBlank())
            val textWatcher = et.addTextChangedListener {
                btnSubmit.active(!it?.toString().isNullOrBlank())
            }
            fun resetListeners() {
                btnCancel.setOnClickListener(null)
                btnSubmit.setOnClickListener(null)
                et.removeTextChangedListener(textWatcher)
            }
            btnCancel.setOnClickListener {
                dialog.cancel()
                resetListeners()
                co.resume(null)
            }
            btnSubmit.setOnClickListener {
                val str = et.text.toString().replace("\n"," ")
                if (str.isNotBlank()) {
                    dialog.hide()
                    resetListeners()
                    co.resume(str)
                }
            }
            co.invokeOnCancellation {
                dialog.cancel()
                resetListeners()
            }
            dialog.apply {
                setOnCancelListener { co.cancel() }
                show()
                et.requestFocus() // 弹起键盘
            }
        }
    }

    // 发布前的预检
    private fun isPublishable(): Boolean {
        return sectionAdapter.list.all { s -> s.isNotBlank() }
                && !etTopic.text?.toString().isNullOrBlank()
                && sectionAdapter.list.size >= 2
                && sectionAdapter.list.distinct().size == sectionAdapter.list.size
    }

    private fun AppCompatButton.active(active: Boolean = isPublishable()) {
        if (active) {
            setBackgroundResource(R.drawable.declare_ic_btn_background)
        } else {
            setBackgroundResource(R.drawable.declare_ic_btn_background_inactive)
        }
    }

    inner class EditDialogManager {
        val layout = LayoutInflater.from(this@PostActivity).inflate(R.layout.declare_layout_dialog_edit, null)
        val dialog = MaterialDialog(this@PostActivity)
            .customView(view = layout)
            .cornerRadius(literalDp = 8f)
            .maxWidth(literal = 300.dp2px)
        val textInputLayout = layout.findViewById<TextInputLayout>(R.id.text_input_layout)
        val et = layout.findViewById<EditText>(R.id.et)
        val btnCancel = layout.findViewById<AppCompatButton>(R.id.btn_cancel)
        val btnSubmit = layout.findViewById<AppCompatButton>(R.id.btn_submit)
    }

    inner class SubmitDialogManager {
        val layout = LayoutInflater.from(this@PostActivity).inflate(R.layout.declare_layout_dialog_submit, null)
        val dialog = MaterialDialog(this@PostActivity)
            .customView(view = layout)
            .cornerRadius(literalDp = 8f)
            .maxWidth(literal = 300.dp2px)
        val btnCancel = layout.findViewById<AppCompatButton>(R.id.btn_cancel)
        val btnSubmit = layout.findViewById<AppCompatButton>(R.id.btn_submit)

    }

    companion object {
        @JvmStatic
        fun start(context: Context) {
            val starter = Intent(context, PostActivity::class.java)
            context.startActivity(starter)
        }
    }
}