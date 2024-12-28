package com.cyxbs.functions.update.api

import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.LiveData

/**
 * Create By Hosigus at 2020/5/3
 */
interface IAppUpdateService {
    // 订阅更新状态
    fun getUpdateStatus(): LiveData<AppUpdateStatus>
    // 检查更新
    fun checkUpdate()
    // 通知用户有更新
    fun noticeUpdate(activity: FragmentActivity)
    // 尝试通知用户更新，内部有时间和状态判断
    fun tryNoticeUpdate(activity: FragmentActivity, isForce: Boolean = false)
    
    
    /**
     * 用于测试更新服务，只在 debug 时才允许调用
     * @param updateContent 更新的内容
     */
    fun debug(activity: FragmentActivity, updateContent: String)
}