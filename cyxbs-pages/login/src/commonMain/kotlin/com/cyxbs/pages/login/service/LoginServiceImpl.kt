package com.cyxbs.pages.login.service

import com.cyxbs.pages.login.api.ILoginService
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/7 21:11
 */
@ImplProvider
object LoginServiceImpl : ILoginService by LoginServicePlatform

expect object LoginServicePlatform : ILoginService {
  override fun jumpToLoginPage()
}