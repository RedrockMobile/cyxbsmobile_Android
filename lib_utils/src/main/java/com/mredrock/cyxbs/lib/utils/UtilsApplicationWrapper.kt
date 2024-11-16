package com.mredrock.cyxbs.lib.utils

import android.app.Application
import android.util.Log
import com.google.auto.service.AutoService
import com.mredrock.cyxbs.init.InitialManager
import com.mredrock.cyxbs.init.InitialService

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/1 12:50
 */
@AutoService(InitialService::class)
class UtilsApplicationWrapper : InitialService {
  
  companion object {
    // 如果遇到未初始化，请使用 BaseApp.baseApp，这里因为依赖关系，只能这样注入
    internal lateinit var application: Application
      private set
  }
  
  override fun onAllProcess(manager: InitialManager) {
    Log.d("ggg", "onAllProcess")
    application = manager.application
  }
}