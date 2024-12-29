package com.cyxbs.pages.login.service

import android.app.Activity
import android.content.Intent
import com.cyxbs.pages.login.api.ILoginService
import com.cyxbs.pages.login.login.ui.LoginActivity
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/7 21:11
 */
@ImplProvider
object LoginServiceImpl : ILoginService {
  
  override fun startLoginActivity(intent: (Intent.() -> Unit)?) {
    LoginActivity.start(intent)
  }
  
  override fun startLoginActivity(
    successActivity: Class<out Activity>,
    intent: (Intent.() -> Unit)?
  ) {
    LoginActivity.start(successActivity, intent)
  }
  
  override fun startLoginActivityReboot(intent: (Intent.() -> Unit)?) {
    LoginActivity.startReboot(intent)
  }
}