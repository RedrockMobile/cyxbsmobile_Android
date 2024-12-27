package com.cyxbs.pages.noclass.page.course

import com.cyxbs.pages.course.widget.item.lesson.ILessonData

/**
 *
 * @ProjectName:    CyxbsMobile_Android
 * @Package:        com.cyxbs.pages.noclass.page.course
 * @ClassName:      NoClassLessonData
 * @Author:         Yan
 * @CreateDate:     2022年09月06日 17:25:00
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 * @Description:
 */
class NoClassLessonData(
  override val weekNum: Int,
  override val startNode: Int,
  override val length: Int,
  val names : String,
) : ILessonData