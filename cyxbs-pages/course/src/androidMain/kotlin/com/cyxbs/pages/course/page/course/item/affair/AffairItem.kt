package com.cyxbs.pages.course.page.course.item.affair

import android.content.Context
import com.cyxbs.pages.course.page.course.data.AffairData
import com.cyxbs.pages.course.page.course.data.ICourseItemData
import com.cyxbs.pages.course.page.course.item.BaseItem
import com.cyxbs.pages.course.page.course.item.affair.lp.AffairLayoutParams
import com.cyxbs.pages.course.page.course.item.affair.helper.AffairTouchHelper
import com.cyxbs.pages.course.page.course.utils.container.base.IDataOwner
import com.cyxbs.pages.course.page.course.utils.container.base.IRecycleItem
import com.cyxbs.pages.course.widget.item.affair.IAffairItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItem
import com.cyxbs.pages.course.widget.item.touch.ITouchItemHelper

/**
 * 显示事务的 Item
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/2 16:43
 */
class AffairItem(
  private var affairData: AffairData,
  private val iAffairManager: IAffairManager
) : BaseItem<AffairView>(),
  IDataOwner<AffairData>,
  IAffairItem,
  IRecycleItem,
  ITouchItem {
  
  override fun setNewData(newData: AffairData) {
    getChildIterable().forEach {
      if (it is AffairView) {
        it.setNewData(newData)
      }
    }
    lp.setNewData(newData)
    affairData = newData
    getRootView()?.requestLayout()
    refreshShowOverlapTag()
  }
  
  override fun createView(context: Context): AffairView {
    return AffairView(context, affairData)
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
    get() = affairData
  
  override val lp: AffairLayoutParams = AffairLayoutParams(affairData)
  
  override val week: Int
    get() = affairData.week
  
  override val data: AffairData
    get() = affairData
  
  override fun initializeTouchItemHelper(): List<ITouchItemHelper> {
    return super.initializeTouchItemHelper() + listOf(
      AffairTouchHelper(iAffairManager)
    )
  }

  override fun toString(): String {
    return "AffairItem(data=$affairData)"
  }
}
