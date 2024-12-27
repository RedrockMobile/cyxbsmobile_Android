package com.cyxbs.pages.course.page.course.item.affair.lp

import com.cyxbs.pages.course.page.course.data.AffairData
import com.cyxbs.pages.course.page.course.item.ISingleDayRank
import com.cyxbs.pages.course.page.course.utils.container.base.IDataOwner
import com.cyxbs.pages.course.widget.item.affair.BaseAffairLayoutParams
import com.ndhzs.netlayout.attrs.NetLayoutParams

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/2 16:44
 */
class AffairLayoutParams(
  override var data: AffairData
) : BaseAffairLayoutParams(data), ISingleDayRank, IDataOwner<AffairData> {
  
  override val rank: Int
    get() = 2
  
  override fun compareTo(other: NetLayoutParams): Int {
    return if (other is ISingleDayRank) compareToInternal(other) else 1
  }
  
  override val week: Int
    get() = data.week
  
  override fun setNewData(newData: AffairData) {
    data = newData
    changeSingleDay(newData)
  }
}