package com.mredrock.cyxbs.sdks

import com.google.auto.service.AutoService
import com.mredrock.cyxbs.BuildConfig
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.init.InitialManager
import com.mredrock.cyxbs.init.InitialService
import com.mredrock.cyxbs.lib.base.BaseApp
import com.mredrock.cyxbs.lib.utils.service.impl
import com.mredrock.lib.crash.core.CyxbsCrashMonitor
import com.tencent.bugly.Bugly
import com.tencent.bugly.crashreport.CrashReport
import com.tencent.vasdolly.helper.ChannelReaderUtil

/**
 * 配置的话可以先看看官方文档：https://bugly.qq.com/docs/
 * 官方文档讲的有点不详细，可以看看这篇文章：https://blog.csdn.net/RungBy/article/details/88794875
 *
 * @author ZhiQiang Tu
 * @time 2022/3/24  19:40
 * @signature 我将追寻并获取我想要的答案
 */
@AutoService(InitialService::class)
class BuglyInitialService : InitialService {
    
    // bugly 会读取 Android id
    override fun onPrivacyAgreed(manager: InitialManager) {
        init(manager)
    }
    
    private fun init(manager: InitialManager) {
        val appContext = manager.application.applicationContext
        
        if (BuildConfig.DEBUG) {
            CrashReport.setUserSceneTag(appContext, 83913)
        } else {
            CrashReport.setUserSceneTag(appContext, 202291)
        }
        
        //设置上报进程
        val strategy = CrashReport.UserStrategy(appContext).apply {
            deviceID = BaseApp.getAndroidID() // 设备 id
            deviceModel = BaseApp.getDeviceModel() // 设备型号
            isUploadProcess = true // 增加上报进程
            appVersion = BuildConfig.VERSION_NAME
            appPackageName = BuildConfig.APPLICATION_ID
            appChannel = ChannelReaderUtil.getChannel(manager.application)
        }
        
        CrashReport.setUserId(
            IAccountService::class.impl.getUserService().getStuNum()
        )
        
        //初始化bugly
        Bugly.init(appContext, BuildConfig.BUGLY_APP_ID, BuildConfig.DEBUG, strategy)

        // 配置 module_crash 的异常上传
        CyxbsCrashMonitor.crashReport = {
            CrashReport.postCatchedException(it)
        }
    }
}