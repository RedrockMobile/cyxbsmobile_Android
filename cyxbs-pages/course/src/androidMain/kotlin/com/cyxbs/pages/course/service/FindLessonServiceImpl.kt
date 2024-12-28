package com.cyxbs.pages.course.service

import android.content.Context
import android.content.Intent
import com.cyxbs.pages.course.api.IFindLessonService
import com.cyxbs.pages.course.page.find.ui.find.activity.FindLessonActivity
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * .
 *
 * @author 985892345
 * @date 2022/9/22 15:54
 */
@ImplProvider
object FindLessonServiceImpl : IFindLessonService {
  
  override fun startActivity(context: Context) {
    context.startActivity(Intent(context, FindLessonActivity::class.java))
  }
  
  override fun startActivityByStuNum(context: Context, stuNum: String) {
    FindLessonActivity.startByStuNum(context, stuNum)
  }
  
  override fun startActivityByStuName(context: Context, stuName: String) {
    FindLessonActivity.startByStuName(context, stuName)
  }
  
  override fun startActivityByTeaNum(context: Context, teaNum: String) {
    FindLessonActivity.startByTeaNum(context, teaNum)
  }
  
  override fun startActivityByTeaName(context: Context, teaName: String) {
    FindLessonActivity.startByTeaName(context, teaName)
  }
}