package com.cyxbs.components.base.operations

import com.cyxbs.components.account.api.IAccountService
import com.cyxbs.components.base.ui.BaseUi
import com.cyxbs.components.utils.service.impl

/**
 * .
 *
 * @author 985892345
 * @date 2024/2/16 17:47
 */

/**
 * 如果没有登录则会引导去登录界面
 */
fun BaseUi.doIfLogin(msg: String? = "此功能", next: (() -> Unit)? = null) {
  val verifyService = IAccountService::class.impl().getVerifyService()
  if (verifyService.isLogin()) {
    next?.invoke()
  } else {
    verifyService.askLogin(rootView.context, "请先登录才能使用${msg}哦~")
  }
}