package com.mredrock.cyxbs.course.service

import android.content.Context
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.api.course.COURSE_LESSON
import com.mredrock.cyxbs.api.course.ILessonService
import com.mredrock.cyxbs.course.page.course.model.StuLessonRepository
import com.mredrock.cyxbs.course.page.course.room.StuLessonEntity
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/5/14 17:09
 */
@Route(path = COURSE_LESSON, name = COURSE_LESSON)
class LessonServiceImpl : ILessonService {
  
  override fun getStuLesson(stuNum: String): Single<List<ILessonService.Lesson>> {
    return StuLessonRepository.getLesson(stuNum)
      .map { it.toLesson() }
  }
  
  override fun observeStuLesson(stuNum: String): Observable<List<ILessonService.Lesson>> {
    return StuLessonRepository.observeLesson(stuNum)
      .map { it.toLesson() }
  }
  
  override fun observeSelfLesson(): Observable<List<ILessonService.Lesson>> {
    return StuLessonRepository.observeSelfLesson()
      .map { it.toLesson() }
  }
  
  override fun init(context: Context) {
  }
}

fun List<StuLessonEntity>.toLesson(): List<ILessonService.Lesson> {
  return buildList {
    this@toLesson.forEach { entity ->
      entity.week.forEach { week ->
        add(
          ILessonService.Lesson(
            entity.stuNum,
            week,
            entity.beginLesson,
            entity.classroom,
            entity.course,
            entity.courseNum,
            entity.day,
            entity.hashDay,
            entity.period,
            entity.rawWeek,
            entity.teacher,
            entity.type
          )
        )
      }
    }
  }
}