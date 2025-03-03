package com.cyxbs.pages.course.page.course.ui.home.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.appcompat.content.res.AppCompatResources
import androidx.core.view.isGone
import com.cyxbs.pages.course.R
import com.cyxbs.pages.course.page.course.ui.home.expose.IHomeCourseVp
import com.cyxbs.pages.course.widget.fragment.vp.AbstractHeaderCourseVpFragment
import com.cyxbs.components.utils.extensions.lazyUnlock
import com.cyxbs.components.utils.extensions.visible

/**
 * 处理关联图标的逻辑
 *
 * 该类只处理关联图标的逻辑，其他功能请不要实现 !!!
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/9/2 15:19
 */
abstract class HomeCourseVpLinkFragment : AbstractHeaderCourseVpFragment(), IHomeCourseVp {

  override fun onCreateView(
    inflater: LayoutInflater,
    container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View = inflater.inflate(R.layout.course_fragment_home_course, container, false)
  
  // 我的关联图标
  override val mIvLink by R.id.course_iv_header_link.view<ImageView>()
  
  private val mDoubleLinkImg by lazyUnlock {
    AppCompatResources.getDrawable(requireContext(), R.drawable.course_ic_item_header_link_double)
  }
  private val mSingleLinkImg by lazyUnlock {
    AppCompatResources.getDrawable(requireContext(), R.drawable.course_ic_item_header_link_single)
  }
  
  override fun isShowingDoubleLesson(): Boolean? {
    if (mIvLink.isGone) return null
    return mIvLink.drawable === mDoubleLinkImg
  }
  
  override fun showDoubleLink() {
    mIvLink.visible()
    mIvLink.setImageDrawable(mDoubleLinkImg)
  }
  
  override fun showSingleLink() {
    mIvLink.visible()
    mIvLink.setImageDrawable(mSingleLinkImg)
  }
  
  override fun showNowWeek(position: Int, positionOffset: Float) {
    super.showNowWeek(position, positionOffset)
    val nowWeekPosition = getPositionByNowWeek()
    if (position == nowWeekPosition || position == nowWeekPosition - 1) {
      val offset = if (position == nowWeekPosition) 1 - positionOffset else positionOffset
      mIvLink.translationX = offset * (mHeader.width - mIvLink.right - 32)
    } else {
      mIvLink.translationX = 0f
    }
  }
}