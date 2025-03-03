package com.cyxbs.pages.course.page.course.item.affair.helper.listener

import android.view.View
import com.cyxbs.pages.course.api.utils.getBeginLesson
import com.cyxbs.pages.course.widget.fragment.page.ICoursePage
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.helper.expand.IExpandableItemListener
import com.cyxbs.pages.course.page.course.item.affair.AffairItem
import com.cyxbs.pages.course.page.course.item.affair.IAffairManager
import com.cyxbs.pages.course.widget.item.touch.helper.expand.ExpandableItemHelper
import com.ndhzs.netlayout.touch.multiple.event.IPointerEvent

/**
 * 针对于 [AffairItem] 的 [ExpandableItemHelper] 的监听
 *
 * @author 985892345
 * 2023/4/19 18:47
 */
class AffairExpandableListener(
  private val iAffairManager: IAffairManager
) : IExpandableItemListener {
  
  override fun onDown(page: ICoursePage, item: ITouchItem, child: View, event: IPointerEvent) {
    item as AffairItem
    // 通知扩展开始
    iAffairManager.onStart(page, item, child)
  }
  
  override fun onEventEnd(
    page: ICoursePage,
    item: ITouchItem,
    child: View,
    event: IPointerEvent,
    isInLongPress: Boolean?,
    isCancel: Boolean
  ) {
    item as AffairItem
    val oldData = item.data
    val newData = oldData.copy(
      beginLesson = getBeginLesson(item.lp.startRow),
      period = item.lp.rowCount
    )
    // 通知数据发生了改变
    iAffairManager.onChange(page, item, child, oldData, newData)
    // 通知扩展结束
    iAffairManager.onEnd(page, item, child)
  }
}