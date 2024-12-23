package com.cyxbs.pages.login.api

import android.content.Context
import com.alibaba.android.arouter.facade.template.IProvider

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/23
 */
interface ILegalNoticeService : IProvider {

  /**
   * 跳转到用户协议页面
   */
  fun startUserAgreementActivity(context: Context)

  /**
   * 跳转到隐私政策页面
   */
  fun startPrivacyPolicyActivity(context: Context)
}