package com.mredrock.cyxbs.lib.base.ui

import android.annotation.SuppressLint
import android.content.pm.ActivityInfo
import android.graphics.Color
import android.os.Bundle
import android.view.View
import androidx.annotation.CallSuper
import androidx.annotation.IdRes
import androidx.core.view.WindowCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import com.mredrock.cyxbs.lib.base.operations.OperationActivity
import com.mredrock.cyxbs.lib.utils.extensions.RxjavaLifecycle
import io.reactivex.rxjava3.disposables.Disposable

/**
 * 绝对基础的抽象
 *
 * 这里面不要跟业务挂钩！！！
 * 比如：使用 api 模块
 * 这种操作请放在 [OperationActivity] 中
 *
 * @author 985892345
 * @email 2767465918@qq.com
 * @date 2021/5/25
 */
abstract class BaseActivity(
  private val options: Options = Options.DEFAULT
) : OperationActivity(options), BaseUi, RxjavaLifecycle {
  
  /**
   * 是否处于转屏或异常重建后的 Activity 状态
   */
  protected var mIsActivityRebuilt = false
    private set
  
  @CallSuper
  @SuppressLint("SourceLockedOrientationActivity")
  override fun onCreate(savedInstanceState: Bundle?) {
    mIsActivityRebuilt = savedInstanceState != null
    super.onCreate(savedInstanceState)
    if (options.isPortraitScreen) { // 锁定竖屏
      requestedOrientation = ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
    }
    
    if (options.isCancelStatusBar) { // 沉浸式状态栏
      cancelStatusBar()
    }
  }
  
  @CallSuper
  override fun onDestroy() {
    super.onDestroy()
    // 取消 Rxjava 流
    mDisposableList.filter { !it.isDisposed }.forEach { it.dispose() }
    mDisposableList.clear()
  }
  
  private fun cancelStatusBar() {
    val window = this.window
    val decorView = window.decorView
    
    // 这是 Android 做了兼容的 Compat 包
    // 注意，使用了下面这个方法后，状态栏不会再有东西占位，
    // 可以给根布局加上 android:fitsSystemWindows=true
    // 不同布局该属性效果不同，请给合适的布局添加
    WindowCompat.setDecorFitsSystemWindows(window, false)
    val windowInsetsController = WindowCompat.getInsetsController(window, decorView)
    windowInsetsController.isAppearanceLightStatusBars = true // 设置状态栏字体颜色为黑色
    window.statusBarColor = Color.TRANSPARENT //把状态栏颜色设置成透明
  }
  
  /**
   * 替换 Fragment 的正确用法。
   * 如果不按照正确方式使用，会造成 ViewModel 失效，
   * 你可以写个 demo 看看在屏幕翻转后 Fragment 的 ViewModel 的 hashcode() 值是不是同一个
   *
   * 其实不是很建议你在 Activity 中拿到这个 Fragment 对象，Fragment 一般是不能直接暴露方法让外面调用的
   */
  protected fun <F : Fragment> replaceFragment(
    @IdRes id: Int,
    func: FragmentTransaction.() -> F
  ) {
    if (lifecycle.currentState == Lifecycle.State.CREATED) {
      // 处于 onCreate 时
      if (mIsActivityRebuilt) {
        // 如果此时 Activity 处于重建状态，Fragment 会自动恢复，不能重复提交而改变之前的状态
        // 因为存在重建前你在 onCreate 中提交的 Fragment 在后面因为点击事件而被替换掉，
        // 如果你在这里进行提交，就会导致本来被取消了的 界面 重新出现
      } else {
        // Activity 正常被创建，即没有被异常摧毁
        supportFragmentManager.beginTransaction()
          .apply { replace(id, func.invoke(this)) }
          .commit()
      }
    } else {
      // 除了 onCreate 外的其他生命周期，直接提交即可，一般也遇不到在 onStart 等生命周期中提交 Fragment
      // 如果你要判断是否重复提交同类型的 Fragment，这是不好判断的，因为 reified 关键字如果匹配到 超类 Fragment 就会导致判断错误
      supportFragmentManager.beginTransaction()
        .apply { replace(id, func.invoke(this)) }
        .commit()
    }
  }
  
  private val mDisposableList = mutableListOf<Disposable>()
  
  /**
   * 实现 [RxjavaLifecycle] 的方法，用于带有生命周期的调用
   */
  final override fun onAddRxjava(disposable: Disposable) {
    mDisposableList.add(disposable)
  }
  
  final override val rootView: View
    get() = window.decorView
  
  final override fun getViewLifecycleOwner(): LifecycleOwner = this
  
  /**
   * Activity 构造时的可选项，写在这里主要是为了集中管理，以前学长是采取重写方法来实现的，
   * 我不是很认同这种写法，这种只用一次的简单变量应该在构造的时候就直接传入，并且重写的话以后人来重构代码很容易被忽略掉
   *
   * 使用接口主要是为了更好的继承
   *
   * 有以下几点需要遵守：
   * - 变量类型不能过于复杂，尽量为 Boolean、String、Int 等简单类型，且不可变 val
   * - 需要提供默认参数
   * - 子类可以继承该接口，然后填充需要的额外参数，使用时请使用 [OptionsImpl]，子类建议使用 kt 的 by 接口 来简化
   */
  interface Options : OperationActivity.Options {
    /**
     * 是否锁定竖屏
     */
    val isPortraitScreen: Boolean
      get() = true
  
    /**
     * 是否沉浸式状态栏
     *
     * 注意，沉浸式后，状态栏不会再有东西占位，界面会默认上移，
     * 可以给根布局加上 android:fitsSystemWindows=true，
     * 不同布局该属性效果不同，请给合适的布局添加
     */
    val isCancelStatusBar: Boolean
      get() = true
    
    companion object {
      val DEFAULT = object : Options {}
    }
  }
  
  open class OptionsImpl(
    override val isCheckLogin: Boolean = true,
    override val isShowToastIfNoLogin: Boolean = true,
    override val isCancelStatusBar: Boolean = true,
    override val isPortraitScreen: Boolean = true
  ) : Options
}
