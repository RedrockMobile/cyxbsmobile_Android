package com.cyxbs.pages.course.widget.fragment.page.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.cyxbs.pages.course.widget.R
import com.cyxbs.pages.course.widget.fragment.course.CourseBaseFragment
import com.cyxbs.pages.course.widget.fragment.page.ICoursePage

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/31 17:38
 */
abstract class AbstractCoursePageFragment : CourseBaseFragment(), ICoursePage {
  
  override fun onCreateView(
    inflater: LayoutInflater,
    container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View {
    return inflater.inflate(R.layout.course_widget_layout_page, container, false)
  }
}