package com.cyxbs.pages.login.service

import com.cyxbs.pages.login.api.ILoginService
import com.cyxbs.pages.login.login.ui.LoginActivity

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/7 21:11
 */
actual object LoginServicePlatform : ILoginService {
  actual override fun jumpToLoginPage() {
    LoginActivity.startReboot(null)
  }
}