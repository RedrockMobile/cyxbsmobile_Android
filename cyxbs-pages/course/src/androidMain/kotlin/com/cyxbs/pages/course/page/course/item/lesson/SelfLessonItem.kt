package com.cyxbs.pages.course.page.course.item.lesson

import android.content.Context
import com.cyxbs.pages.course.page.course.data.ICourseItemData
import com.cyxbs.pages.course.page.course.data.StuLessonData
import com.cyxbs.pages.course.page.course.item.BaseItem
import com.cyxbs.pages.course.page.course.item.lesson.helper.SelfLessonMovableHelper
import com.cyxbs.pages.course.page.course.item.lesson.lp.SelfLessonLayoutParams
import com.cyxbs.pages.course.page.course.utils.container.base.IDataOwner
import com.cyxbs.pages.course.page.course.utils.container.base.IRecycleItem
import com.cyxbs.pages.course.widget.item.lesson.ILessonItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItemHelper

/**
 * 显示自己课程的 Item
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/2 16:43
 */
class SelfLessonItem(private var lessonData: StuLessonData) :
  BaseItem<SelfLessonView>(),
  IDataOwner<StuLessonData>,
  ILessonItem,
  IRecycleItem,
  ITouchItem {
  
  override fun setNewData(newData: StuLessonData) {
    getChildIterable().forEach {
      if (it is SelfLessonView) {
        it.setNewData(newData)
      }
    }
    lp.setNewData(newData)
    lessonData = newData
    getRootView()?.requestLayout()
    refreshShowOverlapTag()
  }
  
  override fun createView(context: Context): SelfLessonView {
    return SelfLessonView(context, lessonData)
  }
  
  override val isHomeCourseItem: Boolean
    get() = true
  
  override fun onRecycle(): Boolean {
    return true
  }
  
  override fun onReuse(): Boolean {
    val view = getRootView() ?: return true
    return view.run {
      parent == null && !isAttachedToWindow && view.animation == null
    }
  }
  
  override val rank: Int
    get() = lp.rank
  
  override val iCourseItemData: ICourseItemData
    get() = lessonData
  
  override val lp: SelfLessonLayoutParams = SelfLessonLayoutParams(lessonData)
  
  override val week: Int
    get() = lessonData.week
  
  override val data: StuLessonData
    get() = lessonData
  
  override fun initializeTouchItemHelper(): List<ITouchItemHelper> {
    return super.initializeTouchItemHelper() + listOf(
      SelfLessonMovableHelper()
    )
  }

  override fun toString(): String {
    return "SelfLessonItem(data=$data)"
  }
}