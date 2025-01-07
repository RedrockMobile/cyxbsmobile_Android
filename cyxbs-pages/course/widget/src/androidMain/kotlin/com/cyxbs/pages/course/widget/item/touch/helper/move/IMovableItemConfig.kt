package com.cyxbs.pages.course.widget.item.touch.helper.move

import android.view.View
import com.cyxbs.pages.course.widget.fragment.page.ICoursePage
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.helper.longpress.ILongPressItemConfig
import com.cyxbs.pages.course.widget.item.touch.helper.move.utils.DefaultMovableHandler
import com.cyxbs.pages.course.widget.item.touch.helper.move.utils.LocationUtil
import com.ndhzs.netlayout.touch.multiple.event.IPointerEvent

/**
 * [MovableItemHelper] 的相关配置
 *
 * @author 985892345
 * 2023/2/19 20:52
 */
interface IMovableItemConfig : ILongPressItemConfig {
  
  /**
   * 新位置是否允许与 [other] 重叠
   *
   * 如果允许的话，则可以认为该 item 可以与 View 重叠显示，正常情况是不重叠显示的
   */
  fun isAllowOverlap(page: ICoursePage, item: ITouchItem, self: View, other: View): Boolean = false
  
  override fun isLongPress(
    event: IPointerEvent,
    page: ICoursePage,
    item: ITouchItem,
    child: View
  ): Boolean = true
  
  /**
   * 是否允许移动到 [newLocation]
   */
  fun isMovableToNewLocation(
    page: ICoursePage,
    item: ITouchItem,
    child: View,
    newLocation: LocationUtil.Location
  ): Boolean = true
  
  /**
   * 得到处理 View 移动的工具类
   */
  fun getMovableHandler(): IMovableItemHandler {
    return DefaultMovableHandler()
  }
  
  companion object Default : IMovableItemConfig
}