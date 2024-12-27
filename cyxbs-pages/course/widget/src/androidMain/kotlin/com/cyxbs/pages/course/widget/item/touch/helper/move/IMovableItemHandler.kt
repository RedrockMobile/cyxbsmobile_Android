package com.cyxbs.pages.course.widget.item.touch.helper.move

import com.cyxbs.pages.course.widget.item.touch.helper.move.utils.DefaultMovableHandler

/**
 * 默认实现类请看 [DefaultMovableHandler]
 *
 * @author 985892345
 * 2023/4/22 12:39
 */
interface IMovableItemHandler : IMovableItemListener {
  
  /**
   * 得到最后移动到新位置或者回到原位置的动画时长
   */
  fun getMoveAnimatorDuration(): Long
}