package com.cyxbs.applications.pro

import com.cyxbs.components.base.BaseApp
import com.g985892345.provider.cyxbsmobile.cyxbsapplications.pro.ProKtProviderInitializer

/**
 * Created By jay68 on 2018/8/8.
 */
class ProApp : BaseApp() {
  override fun initProvider() {
    ProKtProviderInitializer.tryInitKtProvider()
  }
}
