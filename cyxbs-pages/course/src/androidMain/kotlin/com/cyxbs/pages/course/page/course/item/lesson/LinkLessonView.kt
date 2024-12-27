package com.cyxbs.pages.course.page.course.item.lesson

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import com.cyxbs.pages.course.api.utils.parseClassRoom
import com.cyxbs.pages.course.R
import com.cyxbs.pages.course.page.course.data.StuLessonData
import com.cyxbs.pages.course.page.course.item.view.IOverlapTag
import com.cyxbs.pages.course.page.course.item.view.OverlapTagHelper
import com.cyxbs.pages.course.page.course.utils.container.base.IDataOwner
import com.cyxbs.pages.course.widget.item.view.ItemView
import com.cyxbs.components.utils.extensions.color

/**
 * 显示关联人课程的 View
 *
 * @author 985892345
 * 2023/4/19 19:14
 */
@SuppressLint("ViewConstructor")
class LinkLessonView(
  context: Context,
  override var data: StuLessonData
) : ItemView(context), IOverlapTag, IDataOwner<StuLessonData> {
  
  private val mBgColor = R.color.course_widget_link_lesson_bg.color
  private val mTextColor = R.color.course_widget_link_lesson_tv.color
  
  private val mHelper = OverlapTagHelper(this)
  
  override fun onDraw(canvas: Canvas) {
    super.onDraw(canvas)
    mHelper.drawOverlapTag(canvas)
  }
  
  override fun setIsShowOverlapTag(isShow: Boolean) {
    mHelper.setIsShowOverlapTag(isShow)
  }
  
  init {
    setNewData(data)
    tvTitle.setTextColor(mTextColor)
    tvContent.setTextColor(mTextColor)
    setCardBackgroundColor(mBgColor)
    mHelper.setOverlapTagColor(mTextColor)
  }
  
  override fun setNewData(newData: StuLessonData) {
    data = newData
    setText(data.course.course, parseClassRoom(data.course.classroom))
  }
}