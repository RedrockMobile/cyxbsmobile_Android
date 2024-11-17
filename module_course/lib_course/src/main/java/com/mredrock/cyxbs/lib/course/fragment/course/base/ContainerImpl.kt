package com.mredrock.cyxbs.lib.course.fragment.course.base

import android.os.Bundle
import android.view.View
import android.view.animation.AlphaAnimation
import androidx.annotation.CallSuper
import com.mredrock.cyxbs.lib.course.fragment.course.expose.container.ICourseContainer
import com.mredrock.cyxbs.lib.course.internal.item.IItem
import com.mredrock.cyxbs.lib.course.internal.item.IItemContainer
import com.mredrock.cyxbs.lib.course.item.affair.IAffairItem
import com.mredrock.cyxbs.lib.course.item.lesson.ILessonItem
import com.mredrock.cyxbs.lib.course.utils.forEachInline
import java.util.*

/**
 * 掌控 [ILessonItem] 和 [IAffairItem] 的容器
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/25 15:36
 */
abstract class ContainerImpl : AbstractCourseBaseFragment(), ICourseContainer {
  
  private val mLessons = hashSetOf<ILessonItem>()
  private val mAffairs = hashSetOf<IAffairItem>()
  
  init {
    // 回收 item，解决 Fragment 与 View 生命周期不一致问题
    doOnCourseDestroy {
      mLessons.clear()
      mAffairs.clear()
    }
  }
  
  final override fun addLesson(lesson: ILessonItem) {
    mLessons.add(lesson)
    course.addItem(lesson)
  }
  
  final override fun addLesson(lessons: List<ILessonItem>) {
    lessons.forEachInline { addLesson(it) }
  }
  
  final override fun removeLesson(lesson: ILessonItem) {
    course.removeItem(lesson)
    mLessons.remove(lesson)
  }
  
  final override fun clearLesson() {
    // 因为后面的监听中会调用 mLessons.remove()，所以这里使用迭代先删除，不然迭代中在其他地方删除会报异常
    val iterator = mLessons.iterator()
    while (iterator.hasNext()) {
      val next = iterator.next()
      iterator.remove() // 先删除
      course.removeItem(next)
    }
  }
  
  final override fun getLessonsSize(): Int {
    return mLessons.size
  }
  
  final override fun containLesson(lesson: ILessonItem?): Boolean {
    return mLessons.contains(lesson)
  }
  
  override fun getLessonSet(): Set<ILessonItem> {
    return Collections.unmodifiableSet(mLessons)
  }
  
  
  
  final override fun addAffair(affair: IAffairItem) {
    mAffairs.add(affair)
    course.addItem(affair)
  }
  
  final override fun addAffair(affairs: List<IAffairItem>) {
    affairs.forEachInline { addAffair(it) }
  }
  
  final override fun removeAffair(affair: IAffairItem) {
    course.removeItem(affair)
    mAffairs.remove(affair)
  }
  
  final override fun clearAffair() {
    // 因为后面的监听中会调用 mLessons.remove()，所以这里使用迭代先删除，不然迭代中在其他地方删除会报异常
    val iterator = mAffairs.iterator()
    while (iterator.hasNext()) {
      val next = iterator.next()
      iterator.remove() // 先删除
      course.removeItem(next)
    }
  }
  
  final override fun getAffairsSize(): Int {
    return mAffairs.size
  }
  
  final override fun containAffair(affair: IAffairItem?): Boolean {
    return mAffairs.contains(affair)
  }
  
  override fun getAffairSet(): Set<IAffairItem> {
    return Collections.unmodifiableSet(mAffairs)
  }
  
  /**
   * 设置退场动画
   *
   * 退场动画可以统一，但入场动画不好把握时机，需要自己单独调用
   */
  private fun startExitAnimation(view: View) {
    val animation = AlphaAnimation(1F, 0F).apply { duration = 360 }
    view.startAnimation(animation)
  }
  
  
  
  @CallSuper
  override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    super.onViewCreated(view, savedInstanceState)
    
    // 可能存在使用其他方法添加进来的，所以需要监听一下
    course.addItemExistListener(
      object : IItemContainer.OnItemExistListener {
        
        override fun onItemAddedAfter(item: IItem, view: View?) {
          when (item) {
            is ILessonItem -> mLessons.add(item)
            is IAffairItem -> mAffairs.add(item)
          }
        }
  
        override fun onItemRemovedBefore(item: IItem, view: View?) {
          when (item) {
            is ILessonItem, is IAffairItem -> {
              if (view != null) {
                if (view.isAttachedToWindow) {
                  // 只对还显示在屏幕内的 view 开启动画
                  // 在移除前开启动画，父 View 会临时保存进 mDisappearingChildren 直到动画结束
                  startExitAnimation(view)
                }
              }
            }
          }
        }
  
        override fun onItemRemovedAfter(item: IItem, view: View?) {
          when (item) {
            is ILessonItem -> mLessons.remove(item)
            is IAffairItem -> mAffairs.remove(item)
          }
        }
      }
    )
  }
}