package com.cyxbs.pages.course.widget.item.single

import com.cyxbs.pages.course.widget.internal.item.IItem

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/20 20:22
 */
interface ISingleDayItem : IItem {
  
  /**
   * 正确继承写法：
   * ```
   * override val lp = SingleDayLayoutParams(data)
   * ```
   */
  override val lp: SingleDayLayoutParams
}