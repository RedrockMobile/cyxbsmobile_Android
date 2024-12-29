package com.cyxbs.components.config.route

import android.app.Activity
import com.cyxbs.components.config.route.defaultpage.DefaultPageActivity
import kotlin.reflect.KClass

/**
 * activity 拦截器，被拦截的页面进入 DefaultPageActivity
 *
 * @author 985892345
 * @date 2024/12/28
 */
object ActivityInterceptor {

  private val interceptPaths = setOf(
    //教务在线信息
    DISCOVER_NEWS,
    DISCOVER_NEWS_ITEM,
    //我的考试
    DISCOVER_GRADES,
    //志愿服务
    DISCOVER_VOLUNTEER,
    DISCOVER_VOLUNTEER_RECORD,
  )

  fun get(path: String): KClass<out Activity>? {
   return if (path in interceptPaths) DefaultPageActivity::class else null
  }
}