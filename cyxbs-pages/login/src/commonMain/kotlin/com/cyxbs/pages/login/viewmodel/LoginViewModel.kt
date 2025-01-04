package com.cyxbs.pages.login.viewmodel

import androidx.compose.runtime.mutableStateOf
import com.cyxbs.components.base.ui.BaseViewModel


/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
expect class LoginViewModel(): CommonLoginViewModel

abstract class CommonLoginViewModel : BaseViewModel() {

  val username = mutableStateOf("")

  val password = mutableStateOf("")

  val isCheckUserArgument = mutableStateOf(false)

  val isLoginAnim = mutableStateOf(false)

  fun clickLogin() {
    if (isLoginAnim.value) return
    if (!isCheckUserArgument.value) {
      toast("请先同意用户协议吧")
    } else if (username.value.isEmpty()) {
      toast("请输入学号")
    } else if (password.value.length < 6) {
      toast("请检查一下密码吧，似乎有点问题")
    } else {
      isLoginAnim.value = true
      launch {
        try {
          login()
        } finally {
          isLoginAnim.value = false
        }
      }
    }
  }

  abstract suspend fun login()

  abstract fun clickForgetPassword()

  abstract fun clickUserAgreement()

  abstract fun clickPrivacyPolicy()

  fun clickTouristMode() {
    if (!isCheckUserArgument.value) {
      toast("请先同意用户协议吧")
    } else {
      enterTouristMode()
    }
  }

  abstract fun enterTouristMode()
}
