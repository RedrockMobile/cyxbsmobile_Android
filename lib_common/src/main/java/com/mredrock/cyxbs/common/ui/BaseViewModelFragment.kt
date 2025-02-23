@file:Suppress("UNCHECKED_CAST")

package com.mredrock.cyxbs.common.ui

import android.app.ProgressDialog
import android.os.Bundle
import android.widget.Toast
import androidx.lifecycle.ViewModelProvider
import com.cyxbs.components.base.ui.BaseFragment
import com.mredrock.cyxbs.common.component.CyxbsToast
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import com.mredrock.cyxbs.common.viewmodel.event.ProgressDialogEvent
import java.lang.reflect.ParameterizedType

/**
 * Created By jay68 on 2018/8/23.
 */
abstract class BaseViewModelFragment<T : BaseViewModel> : BaseFragment() {
    protected lateinit var viewModel: T


    private var progressDialog: ProgressDialog? = null

    private fun initProgressBar() = ProgressDialog(context).apply {
        isIndeterminate = true
        setMessage("Loading...")
        setOnDismissListener { viewModel.onProgressDialogDismissed() }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val viewModelFactory = getViewModelFactory()
        val viewModelClass = (javaClass.genericSuperclass as ParameterizedType).actualTypeArguments[0] as Class<T>
        viewModel = if (viewModelFactory != null) {
            ViewModelProvider(this, viewModelFactory).get(viewModelClass)
        } else {
            ViewModelProvider(this).get(viewModelClass)
        }
        
        viewModel.apply {
            toastEvent.observe(this@BaseViewModelFragment) { str -> str?.let { CyxbsToast.makeText(requireContext(), it, Toast.LENGTH_SHORT).show() } }
            longToastEvent.observe(this@BaseViewModelFragment) { str -> str?.let { CyxbsToast.makeText(requireContext(), it, Toast.LENGTH_LONG).show() } }
            progressDialogEvent.observe(this@BaseViewModelFragment) {
                it ?: return@observe
                // 确保只有一个对话框会被弹出
                if (it != ProgressDialogEvent.DISMISS_DIALOG_EVENT && progressDialog?.isShowing != true) {
                    progressDialog = progressDialog ?: initProgressBar()
                    progressDialog?.show()
                } else if (it == ProgressDialogEvent.DISMISS_DIALOG_EVENT && progressDialog?.isShowing != false) {
                    progressDialog?.dismiss()
                }
            }
        }
    }

    protected open fun getViewModelFactory(): ViewModelProvider.Factory? = null
    
    override fun onDestroyView() {
        super.onDestroyView()
        if (progressDialog?.isShowing == true) {
            progressDialog?.dismiss()
        }
    }
}