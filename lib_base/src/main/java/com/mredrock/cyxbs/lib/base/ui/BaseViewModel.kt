package com.mredrock.cyxbs.lib.base.ui

import android.content.Context
import androidx.annotation.CallSuper
import androidx.lifecycle.*
import com.mredrock.cyxbs.lib.base.BaseApp
import com.mredrock.cyxbs.lib.base.utils.RxjavaLifecycle
import com.mredrock.cyxbs.lib.base.utils.ToastUtils
import io.reactivex.rxjava3.disposables.Disposable
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.launch

/**
 *
 * ## 一、Flow 相关 collect 封装
 * ### collectLaunch()
 * ```
 * mViewModel.flow
 *     .collectLaunch {
 *         // 配合生命周期的收集方法，可以少写一个 lifecycleScope.launch {} 包在外面
 *     }
 * ```
 *
 * ## 二、Rxjava 绑定生命周期
 * ```
 * IXXXApiService::class.api
 *     .getXXX()
 *     .safeSubscribeBy {
 *         // 使用 safeSubscribeBy() 将 Rxjava 流与生命周期相关联，实现自动取消
 *     }
 * ```
 *
 *
 *
 *
 *
 *
 * # 更多封装请往父类和接口查看
 */
abstract class BaseViewModel : ViewModel(), RxjavaLifecycle, ToastUtils {
  
  val appContext: Context
    get() = BaseApp.baseApp
  
  private val mDisposableList = mutableListOf<Disposable>()
  
  @CallSuper
  override fun onCleared() {
    super.onCleared()
    mDisposableList
      .filter { !it.isDisposed }
      .forEach { it.dispose() }
    mDisposableList.clear()
  }
  
  /**
   * 开启协程并收集 Flow
   */
  protected fun <T> Flow<T>.collectLaunch(action: suspend (value: T) -> Unit) {
    viewModelScope.launch {
      collect{ action.invoke(it) }
    }
  }
  
  /**
   * 返回一个缓存值为 0 表示事件的 SharedFlow，不会因为 Activity 重建而出现数据倒灌问题
   *
   * [关于状态跟事件的区别可以看这篇文章](https://juejin.cn/post/7046191406825603109)
   */
  protected fun <T> LiveData<T>.asShareFlow(): SharedFlow<T> {
    val sharedFlow = MutableSharedFlow<T>()
    observeForever {
      viewModelScope.launch {
        sharedFlow.emit(it)
      }
    }
    return sharedFlow
  }
  
  
  
  
  
  
  
  
  /**
   * 实现 [RxjavaLifecycle] 的方法，用于带有生命周期的调用
   */
  final override fun onAddRxjava(disposable: Disposable) {
    mDisposableList.add(disposable)
  }
}