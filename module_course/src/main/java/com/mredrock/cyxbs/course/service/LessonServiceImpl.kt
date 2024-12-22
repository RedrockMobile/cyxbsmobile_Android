package com.mredrock.cyxbs.course.service

import android.content.Context
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.api.course.COURSE_LESSON
import com.mredrock.cyxbs.api.course.ILessonService
import com.mredrock.cyxbs.course.page.course.model.StuLessonRepository
import com.mredrock.cyxbs.course.page.course.room.StuLessonEntity
import com.mredrock.cyxbs.course.page.link.model.LinkRepository
import com.mredrock.cyxbs.lib.utils.service.ServiceManager
import com.mredrock.cyxbs.lib.utils.utils.judge.NetworkUtil
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.rx3.asObservable

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/5/14 17:09
 */
@Route(path = COURSE_LESSON, name = COURSE_LESSON)
class LessonServiceImpl : ILessonService {
  
  private val mAccountService = ServiceManager(IAccountService::class)

  override fun refreshLesson(
    stuNum: String,
  ): Single<List<ILessonService.Lesson>> {
    return StuLessonRepository.refreshLesson(stuNum)
      .map { it.toLesson() }
  }

  override fun getStuLesson(stuNum: String): Single<List<ILessonService.Lesson>> {
    return StuLessonRepository.getLesson(stuNum)
      .map { it.toLesson() }
  }
  
  override fun getSelfLesson(): Single<List<ILessonService.Lesson>> {
    val stuNum = mAccountService.getUserService().getStuNum()
    return if (stuNum.isBlank()) Single.error(IllegalStateException("未登录"))
    else getStuLesson(stuNum)
  }
  
  override fun getLinkLesson(): Single<List<ILessonService.Lesson>> {
    return LinkRepository.getLinkStudent()
      .doOnSuccess {
        if (it.isNull()) throw IllegalStateException("当前登录人(${it.selfNum}关联人为空)")
      }.flatMap {
        getStuLesson(it.selfNum)
      }
  }
  
  override fun observeSelfLesson(): Observable<List<ILessonService.Lesson>> {
    return observeSelfLessonInternal().map { it.toLesson() }
  }

  override fun observeLinkLesson(): Observable<List<ILessonService.Lesson>> {
    return observeLinkLessonInternal().map { it.toLesson() }
  }

  override fun init(context: Context) {
  }

  companion object {
    fun observeSelfLessonInternal(
      isToast: Boolean = false,
    ): Observable<List<StuLessonEntity>> {
      return StuLessonRepository.observeSelfLesson(isToast = isToast)
    }

    fun observeLinkLessonInternal(): Observable<List<StuLessonEntity>> {
      return LinkRepository.observeLinkStudent()
        .switchMap { entity ->
          // 没得关联人和不显示关联课程时发送空数据
          if (entity.isNull() || !entity.isShowLink) Observable.just(emptyList()) else {
            flow {
              if (!ILessonService.isUseLocalSaveLesson) {
                // 如果不允许使用本地数据就挂起直到网络连接成功
                NetworkUtil.suspendUntilAvailable()
              }
              emit(Unit)
            }.asObservable()
              .flatMap {
                // 在没有连接网络时 StuLessonRepository.getLesson() 方法会抛出异常
                StuLessonRepository.getLesson(entity.linkNum).toObservable()
              }.onErrorReturn {
                emptyList()
              }
          }
        }
    }
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