package com.cyxbs.pages.course.page.find.ui.course.stu

import androidx.fragment.app.createViewModelLazy
import com.cyxbs.pages.course.page.course.data.StuLessonData
import com.cyxbs.pages.course.page.find.ui.course.base.BaseFindSemesterFragment
import com.cyxbs.pages.course.page.find.ui.course.item.StuLessonItem
import com.cyxbs.pages.course.page.find.ui.course.stu.viewmodel.FindStuCourseViewModel
import com.cyxbs.pages.course.widget.item.lesson.ILessonItem

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/12 16:52
 */
class FindStuSemesterFragment : BaseFindSemesterFragment<StuLessonData>() {
  
  override val mParentViewModel by createViewModelLazy(
    FindStuCourseViewModel::class,
    { requireParentFragment().viewModelStore }
  )
  
  override fun List<StuLessonData>.getLessonItem(): List<ILessonItem> {
    return map { StuLessonItem(it) }
  }
}