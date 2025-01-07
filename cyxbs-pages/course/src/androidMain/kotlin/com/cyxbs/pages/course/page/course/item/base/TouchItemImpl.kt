package com.cyxbs.pages.course.page.course.item.base

import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItemHelper
import com.cyxbs.pages.course.widget.item.touch.TouchItemHelper
import com.cyxbs.pages.course.widget.item.touch.helper.click.ClickItemHelper
import com.cyxbs.components.utils.extensions.lazyUnlock
import com.cyxbs.pages.course.page.course.item.affair.helper.AffairTouchHelper
import com.cyxbs.pages.course.widget.item.touch.helper.expand.ExpandableItemHelper
import com.cyxbs.pages.course.widget.item.touch.helper.move.MovableItemHelper

/**
 * 设置 Item 通用 Touch 事件的基类
 *
 * ## 注意：
 * - 已通过 [ClickItemHelper] 实现多指触摸下的 item 点击事件
 *
 * @author 985892345
 * 2023/2/22 12:18
 */
abstract class TouchItemImpl : SingleDayItemImpl(), ITouchItem {
  
  final override val touchHelper: ITouchItemHelper by lazyUnlock {
    TouchItemHelper(*initializeTouchItemHelper().toTypedArray())
  }

  /**
   * 处理当前 item 触摸事件的帮助类
   *
   * 可以参考：
   * - [ClickItemHelper]        多指触摸点击
   * - [ExpandableItemHelper]   长按边缘区域拖动扩大 item 长度
   * - [MovableItemHelper]      长按 item 移动
   * - [AffairTouchHelper]      事务触摸事件帮助类，处理同时包含 [ExpandableItemHelper] 和 [MovableItemHelper] 时的事件冲突处理
   */
  open fun initializeTouchItemHelper(): List<ITouchItemHelper> {
    return listOf(
      // 默认添加了点击 item 的监听
      ClickItemHelper {
        showCourseBottomDialog()
      }
    )
  }
}