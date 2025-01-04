package com.cyxbs.pages.mine.page.security.util

import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.widget.Button
import androidx.core.content.ContextCompat
import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.mine.R

/**
 * Author: RayleighZ
 * Time: 2020-11-19 21:34
 * Describe: 本模块输入问题的答案的泛用性TextWatcher
 */
open class AnswerTextWatcher(private val tipOF: MutableLiveData<String>, val button: Button, val context: Context) : TextWatcher {
    open val min = 2
    open val max = 16
    override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
    }

    override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
    }

    override fun afterTextChanged(s: Editable?) {
        s?.let {
            when {
                it.length < min -> {
                    tipOF.postValue("请至少输入2个字符")
                    button.background = ContextCompat.getDrawable(context, R.drawable.mine_shape_round_corner_light_blue)
                }
                it.length >= max -> {
                    tipOF.postValue("输入已达上限")
                }
                else -> {
                    tipOF.postValue("")
                    button.background = ContextCompat.getDrawable(context, R.drawable.mine_shape_round_corner_purple_blue)
                }
            }
        }
    }
}