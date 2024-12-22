package com.cyxbs.pages.course.page.course.ui.home.widget.helper.listener

import android.view.View
import com.cyxbs.pages.course.page.course.ui.home.widget.HomeTouchAffairItem
import com.cyxbs.pages.course.page.course.ui.home.widget.helper.TouchAffairTouchHelper
import com.cyxbs.pages.course.widget.fragment.page.ICoursePage
import com.cyxbs.pages.course.widget.item.helper.expand.ISingleSideExpandable
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.helper.expand.utils.DefaultExpandableHandler
import com.ndhzs.netlayout.touch.multiple.event.IPointerEvent

/**
 * [TouchAffairTouchHelper] 中 Expandable 的自定义 Handler
 *
 * @author 985892345
 * 2023/4/23 18:20
 */
class TouchAffairExpandableHandler : DefaultExpandableHandler() {
  override fun newSingleSideExpandable(
    page: ICoursePage,
    item: ITouchItem,
    child: View,
    event: IPointerEvent
  ): ISingleSideExpandable {
    return (item as HomeTouchAffairItem).mSideExpandable
  }
}