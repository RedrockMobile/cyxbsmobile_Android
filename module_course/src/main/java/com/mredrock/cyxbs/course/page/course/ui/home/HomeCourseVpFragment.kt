package com.mredrock.cyxbs.course.page.course.ui.home

import android.os.Bundle
import android.view.View
import androidx.fragment.app.viewModels
import com.mredrock.cyxbs.config.config.SchoolCalendarUtil
import com.mredrock.cyxbs.course.page.course.ui.home.base.HomeCourseVpLinkFragment
import com.mredrock.cyxbs.course.page.course.ui.home.viewmodel.HomeCourseViewModel
import com.mredrock.cyxbs.course.page.find.ui.find.activity.FindLessonActivity
import com.mredrock.cyxbs.lib.course.fragment.page.CoursePageFragment
import com.mredrock.cyxbs.lib.utils.extensions.gone
import com.mredrock.cyxbs.lib.utils.extensions.setOnSingleClickListener

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/20 16:53
 */
class HomeCourseVpFragment : HomeCourseVpLinkFragment() {
  
  private val mViewModel by viewModels<HomeCourseViewModel>()
  
  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)
    initTouch()
    initViewPager()
    initObserve()
  }
  
  override fun createFragment(position: Int): CoursePageFragment {
    return if (position == 0) HomeSemesterFragment() else HomeWeekFragment.newInstance(position)
  }
  
  private fun initTouch() {
    mIvLink.setOnSingleClickListener {
      val isShowingDouble = isShowingDoubleLesson() ?: return@setOnSingleClickListener
      if (isShowingDouble) {
        showSingleLink()
        mViewModel.changeLinkStuVisible(false)
      } else {
        showDoubleLink()
        mViewModel.changeLinkStuVisible(true)
      }
    }
    
    mIvLink.setOnLongClickListener {
      val linkNum = mViewModel.linkStu.value?.linkNum
      return@setOnLongClickListener if (linkNum != null) {
        FindLessonActivity.startByStuNum(it.context, linkNum)
        true
      } else false
    }
    
    mTvWhichWeek.setOnLongClickListener {
      // 长按第几周可刷新课表数据
      mViewModel.refreshData()
      true
    }
  }
  
  private fun initViewPager() {
    /**
     * 观察第几周，因为如果是初次进入应用，会因为得不到周数而不主动翻页，所以只能观察该数据
     * 但这是因为主页课表比较特殊而进行观察，其他界面可以直接使用 [mNowWeek] 变量
     */
    SchoolCalendarUtil.observeWeekOfTerm()
      .firstElement()
      .safeSubscribeBy {
        // 初次加载时移到对应的周数
        // 这里课表的翻页不建议带有动画，因为数据过多会较卡
        mViewPager.setCurrentItem(if (it >= mVpAdapter.itemCount) 0 else it, false)
      }
  }
  
  private fun initObserve() {
    mViewModel.linkStu.observe {
      if (it.isNull()) {
        mIvLink.gone()
      } else {
        if (it.isShowLink) {
          showDoubleLink()
        } else {
          showSingleLink()
        }
      }
    }
    mViewModel.refreshEvent.collectLaunch {
      if (it) {
        toast("刷新成功！")
      } else {
        toast("刷新失败！")
      }
    }
    
    mViewModel.courseService.headerAlphaState.observe {
      mHeader.alpha = it
    }
    mViewModel.courseService.courseVpAlphaState.observe {
      mViewPager.alpha = it
    }
  }
}