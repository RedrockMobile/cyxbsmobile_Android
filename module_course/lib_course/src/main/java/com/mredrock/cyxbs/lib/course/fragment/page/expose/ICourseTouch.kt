package com.mredrock.cyxbs.lib.course.fragment.page.expose

import com.mredrock.cyxbs.lib.course.helper.CourseDownAnimDispatcher
import com.mredrock.cyxbs.lib.course.internal.touch.IMultiTouch

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/31 18:23
 */
interface ICourseTouch : IMultiTouch.DefaultHandler {
  fun getCourseDownAnimDispatcher(): CourseDownAnimDispatcher?
}