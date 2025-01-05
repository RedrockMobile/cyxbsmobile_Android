package com.cyxbs.pages.login.viewmodel

import androidx.compose.runtime.Stable
import androidx.compose.runtime.mutableStateOf
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.logg


/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
expect class LoginViewModel(): CommonLoginViewModel

@Stable
abstract class CommonLoginViewModel : BaseViewModel() {

  val username = mutableStateOf("")

  val password = mutableStateOf("")

  val isCheckUserArgument = mutableStateOf(false)

  val isLoginAnim = mutableStateOf(false)

  // 点击登录
  fun clickLogin() {
    logg("111 ${isLoginAnim.value}")
    if (isLoginAnim.value) return
    if (!isCheckUserArgument.value) {
      toast("请先同意用户协议吧")
    } else if (username.value.isEmpty()) {
      toast("请输入学号")
    } else if (password.value.length < 6) {
      toast("请检查一下密码吧，似乎有点问题")
    } else {
      logg("222")
      isLoginAnim.value = true
      launch {
        try {
          logg("333")
          login()
        } finally {
          isLoginAnim.value = false
        }
      }
    }
  }

  // 登录操作
  abstract suspend fun login()

  // 点击忘记密码
  abstract fun clickForgetPassword()

  // 点击用户协议
  abstract fun clickUserAgreement()

  // 点击隐私政策
  abstract fun clickPrivacyPolicy()

  // 点击游客模式
  fun clickTouristMode() {
    if (!isCheckUserArgument.value) {
      toast("请先同意用户协议吧")
    } else {
      enterTouristMode()
    }
  }

  // 进入游客模式
  abstract fun enterTouristMode()

  // 不同意用户协议
  abstract fun clickDisagreeUserAgreement()
}
