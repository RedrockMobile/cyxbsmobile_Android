package com.cyxbs.pages.course.page.course.item.affair.helper.listener

import android.view.View
import com.cyxbs.pages.course.api.utils.getBeginLesson
import com.cyxbs.pages.course.widget.fragment.page.ICoursePage
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.helper.move.IMovableItemListener
import com.cyxbs.pages.course.widget.item.touch.helper.move.utils.LocationUtil
import com.cyxbs.pages.course.page.course.item.affair.AffairItem
import com.cyxbs.pages.course.page.course.item.affair.IAffairManager
import com.cyxbs.pages.course.widget.item.touch.helper.move.MovableItemHelper

/**
 * 针对于 [AffairItem] 的 [MovableItemHelper] 的移动逻辑处理类
 *
 * @author 985892345
 * 2023/4/19 18:48
 */
class AffairMovableListener(
  private val iAffairManager: IAffairManager
) : IMovableItemListener {
  
  override fun onLongPressed(
    page: ICoursePage,
    item: ITouchItem,
    child: View,
    x: Int,
    y: Int,
    pointerId: Int
  ) {
    item as AffairItem
    page.changeOverlap(item, false) // 暂时取消重叠
    iAffairManager.onStart(page, item, child)
  }
  
  override fun onOverAnimStart(
    newLocation: LocationUtil.Location?,
    page: ICoursePage, item: ITouchItem, child: View
  ) {
    item as AffairItem
    page.changeOverlap(item, true) // 恢复重叠
    val oldData = item.data
    val newData = if (newLocation != null) {
      oldData.copy(
        hashDay = newLocation.startColumn - 1,
        beginLesson = getBeginLesson(newLocation.startRow),
      )
    } else null
    if (newData != null) {
      iAffairManager.onChange(page, item, child, oldData, newData)
    }
  }
  
  override fun onOverAnimEnd(
    newLocation: LocationUtil.Location?,
    page: ICoursePage,
    item: ITouchItem,
    child: View
  ) {
    item as AffairItem
    iAffairManager.onEnd(page, item, child)
  }
}