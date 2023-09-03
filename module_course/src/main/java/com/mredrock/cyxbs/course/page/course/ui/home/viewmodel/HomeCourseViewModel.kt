package com.mredrock.cyxbs.course.page.course.ui.home.viewmodel

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.mredrock.cyxbs.api.affair.IAffairService
import com.mredrock.cyxbs.api.course.ICourseService
import com.mredrock.cyxbs.api.course.ILessonService
import com.mredrock.cyxbs.course.page.course.data.AffairData
import com.mredrock.cyxbs.course.page.course.data.StuLessonData
import com.mredrock.cyxbs.course.page.course.data.toAffairData
import com.mredrock.cyxbs.course.page.course.data.toStuLessonData
import com.mredrock.cyxbs.course.page.course.model.StuLessonRepository
import com.mredrock.cyxbs.course.page.link.model.LinkRepository
import com.mredrock.cyxbs.course.page.link.room.LinkStuEntity
import com.mredrock.cyxbs.course.service.CourseServiceImpl
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.service.impl
import com.mredrock.cyxbs.lib.utils.utils.judge.NetworkUtil
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.Disposable
import io.reactivex.rxjava3.schedulers.Schedulers
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.launch
import kotlinx.coroutines.rx3.asObservable
import java.util.concurrent.TimeUnit

/**
 * ...
 *
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/27 17:12
 */
class HomeCourseViewModel : BaseViewModel() {

  companion object {
    private const val TAG = "HomeCourseViewModel"
  }
  
  private val _homeWeekData = MutableLiveData<Map<Int, HomePageResult>>()
  val homeWeekData: LiveData<Map<Int, HomePageResult>> get() = _homeWeekData
  
  private val _linkStu = MutableLiveData<LinkStuEntity>()
  val linkStu: LiveData<LinkStuEntity> get() = _linkStu
  
  private val _showLinkEvent = MutableSharedFlow<Boolean>()
  val showLinkEvent: SharedFlow<Boolean> get() = _showLinkEvent
  
  val courseService = ICourseService::class.impl as CourseServiceImpl
  
  // Vp2 的 currentItem
  val currentItem = MutableLiveData<Int>()
  
  /**
   * 改变关联人的可见性
   */
  fun changeLinkStuVisible(isShowLink: Boolean) {
    LinkRepository.changeLinkStuVisible(isShowLink)
      .safeSubscribeBy {
        viewModelScope.launch {
          _showLinkEvent.emit(isShowLink)
        }
      }
    // 这里更新后，所有观察关联人的地方都会重新发送新数据
  }
  
  private var mDataObserveDisposable = initObserve()
  
  /**
   * 取消课表数据的观察流
   *
   * 建议与 [refreshDataObserve] 配合使用
   */
  fun cancelDataObserve() {
    if (!mDataObserveDisposable.isDisposed) {
      mDataObserveDisposable.dispose()
    }
  }
  
  /**
   * 刷新整个课表数据的观察流，相当于刷新课表数据
   */
  fun refreshDataObserve() {
    cancelDataObserve()
    mDataObserveDisposable = initObserve()
  }
  
  /**
   * 注意：整个课表采用了观察者模式。数据库对应的数据改变，会自动修改视图内容
   */
  private fun initObserve(): Disposable {
    // 自己课的观察流
    val selfLessonObservable = StuLessonRepository.observeSelfLesson(true)

    // 关联人课的观察流
    val linkLessonObservable = LinkRepository.observeLinkStudent()
      .timeout(3, TimeUnit.SECONDS, Observable.just(LinkStuEntity.NULL))
      .doOnNext { _linkStu.postValue(it) }
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
            }
        }
      }
  
    // 事务的观察流
    val affairObservable = IAffairService::class.impl
      .observeSelfAffair()
      .timeout(3, TimeUnit.SECONDS, Observable.just(emptyList()))
  
    // 合并观察流
    return Observable.combineLatest(
      selfLessonObservable,
      linkLessonObservable,
      affairObservable
    ) { self, link, affair ->
      // 装换为 data 数据类
      HomePageResultImpl.flatMap(
        self.toStuLessonData(),
        link.toStuLessonData(),
        affair.toAffairData()
      )
    }.doOnError {
      Log.d(TAG, "合并课表数据流发生异常：\n${it.stackTraceToString()}")
    }.subscribeOn(Schedulers.io())
      .safeSubscribeBy {
        _homeWeekData.postValue(it)
      }
  }
  
  
  
  
  interface HomePageResult {
    val self: List<StuLessonData>
    val link: List<StuLessonData>
    val affair: List<AffairData>
    
    companion object Empty : HomePageResult {
      override val self: List<StuLessonData>
        get() = emptyList()
      override val link: List<StuLessonData>
        get() = emptyList()
      override val affair: List<AffairData>
        get() = emptyList()
    }
  }
  
  data class HomePageResultImpl(
    override val self: MutableList<StuLessonData> = arrayListOf(),
    override val link: MutableList<StuLessonData> = arrayListOf(),
    override val affair: MutableList<AffairData> = arrayListOf()
  ) : HomePageResult {
    companion object {
      fun flatMap(
        self: List<StuLessonData>,
        link: List<StuLessonData>,
        affair: List<AffairData>
      ) : Map<Int, HomePageResultImpl> {
        return buildMap {
          self.forEach {
            getOrPut(it.week) { HomePageResultImpl() }
              .self.add(it)
          }
          link.forEach {
            getOrPut(it.week) { HomePageResultImpl() }
              .link.add(it)
          }
          affair.forEach { data ->
            if (data.week == 0) {
              // 因为 affair 模块那边对于整学期的事务使用 week = 0 来记录，
              // 所以这里需要单独做适配，把 week = 0 扩展到每一周去
              repeat(ICourseService.maxWeek) {
                getOrPut(it + 1) { HomePageResultImpl() }
                  .affair.add(data.copy(week = it + 1))
              }
            } else {
              getOrPut(data.week) { HomePageResultImpl() }
                .affair.add(data)
            }
          }
        }
      }
    }
  }
}