package com.cyxbs.pages.course.page.course.item.lesson.lp

import com.cyxbs.pages.course.page.course.data.StuLessonData
import com.cyxbs.pages.course.page.course.data.expose.IWeek
import com.cyxbs.pages.course.page.course.item.ISingleDayRank
import com.cyxbs.pages.course.page.course.utils.container.base.IDataOwner
import com.cyxbs.pages.course.widget.item.lesson.BaseLessonLayoutParams
import com.ndhzs.netlayout.attrs.NetLayoutParams

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/2 17:21
 */
class SelfLessonLayoutParams(
  override var data: StuLessonData
) : BaseLessonLayoutParams(data), ISingleDayRank, IDataOwner<StuLessonData> {
  
  override val rank: Int
    get() = 1
  
  override fun compareTo(other: NetLayoutParams): Int {
    return if (other is ISingleDayRank) compareToInternal(other) else 1
  }
  
  override val week: Int
    get() = data.week
  
  override fun setNewData(newData: StuLessonData) {
    data = newData
    changeSingleDay(newData)
  }
}