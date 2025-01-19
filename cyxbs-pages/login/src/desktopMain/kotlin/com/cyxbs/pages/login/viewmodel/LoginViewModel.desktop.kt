package com.cyxbs.pages.login.viewmodel

import com.cyxbs.pages.login.bean.LoginBean

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
actual class LoginViewModel : CommonLoginViewModel() {

  override suspend fun onLoginSuccess(username: String, bean: LoginBean) {
    super.onLoginSuccess(username, bean)
  }

  override suspend fun onLoginFailure(throwable: Throwable) {
    super.onLoginFailure(throwable)
  }

  override fun clickForgetPassword() {
  }

  override fun clickUserAgreement() {
  }

  override fun clickPrivacyPolicy() {
  }

  override fun enterTouristMode() {
  }

  override fun clickDisagreeUserAgreement() {

  }
}