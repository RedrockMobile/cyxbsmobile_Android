package com.cyxbs.pages.login.viewmodel

import kotlinx.coroutines.delay
import kotlin.time.Duration.Companion.seconds

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
actual class LoginViewModel : CommonLoginViewModel() {
  override suspend fun login() {
    delay(3.seconds)
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