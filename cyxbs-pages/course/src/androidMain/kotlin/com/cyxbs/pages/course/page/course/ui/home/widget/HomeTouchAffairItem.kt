package com.cyxbs.pages.course.page.course.ui.home.widget

import android.content.Context
import com.cyxbs.pages.course.page.course.ui.home.widget.helper.TouchAffairTouchHelper
import com.cyxbs.pages.course.widget.helper.affair.view.TouchAffairView
import com.cyxbs.pages.course.widget.item.helper.expand.ISingleSideExpandable
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItemHelper
import com.cyxbs.pages.course.widget.item.touch.TouchItemHelper

/**
 * 实现 [ITouchItem] 的 [TouchAffairView]
 *
 * @author 985892345
 * 2023/2/19 21:55
 */
class HomeTouchAffairItem(context: Context) : TouchAffairView(context), ITouchItem {
  
  // 改为 public 暴露给外面使用
  public override val mSideExpandable: ISingleSideExpandable
    get() = super.mSideExpandable
  
  override val touchHelper: ITouchItemHelper = TouchItemHelper(
    TouchAffairTouchHelper()
  )
}