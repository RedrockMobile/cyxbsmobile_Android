package com.cyxbs.pages.notification.widget

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Rect
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.VelocityTracker
import android.view.View
import android.view.ViewConfiguration
import android.view.ViewGroup
import android.widget.Scroller
import androidx.recyclerview.widget.RecyclerView
import kotlin.math.abs

/**
 * Author by OkAndGreat
 * Date on 2022/5/4 10:08.
 */
class SwipeDeleteRecyclerView @JvmOverloads constructor(
  context: Context,
  attrs: AttributeSet? = null,
  defStyle: Int = 0
) : RecyclerView(context, attrs, defStyle) {
  private var mVelocityTracker: VelocityTracker? = null // 速度追踪器
  private val mTouchSlop =
    ViewConfiguration.get(context).scaledTouchSlop // 认为是滑动的最小距离（一般由系统提供）
  private val mTouchFrame = Rect() // 子View所在的矩形范围
  private val mScroller = Scroller(context)
  private var mLastX = 0f // 滑动过程中记录上次触碰点X
  private var mFirstX = 0f
  private var mFirstY = 0f // 首次触碰范围
  private var mIsSlide = false // 是否滑动子View
  private var mFlingView: ViewGroup? = null // 触碰的子View
  private var mPosition = 0 // 触碰的view在可见item中的位置
  private var mMenuViewWidth = 0 // 菜单按钮宽度

  private var stateCallback: StateCallback? = null

  var isTouchOpened: Boolean = false

  /**
   * 拦截事件的情况分为以下俩种：
   *
   * ACTION_DOWN时，如果已经有ItemView处于展开状态，并且这次点击的对象不是已打开的那个ItemView，则拦截事件，并将已展开的ItemView关闭。
   *
   * ACTION_MOVE时，有俩判断，满足其一则认为是侧滑：
   *
   * 1. x方向速度大于y方向速度，且大于最小速度限制；
   *
   * 2. x方向的侧滑距离大于y方向滑动距离，且x方向达到最小滑动距离；
   */
  override fun onInterceptTouchEvent(e: MotionEvent): Boolean {
    val x = e.x.toInt()
    val y = e.y.toInt()
    obtainVelocity(e)
    when (e.action) {
      MotionEvent.ACTION_DOWN -> {
        if (!mScroller.isFinished) {
          // 如果动画还没停止，则立即终止动画
          mScroller.abortAnimation()
        }
        run {
          mLastX = x.toFloat()
          mFirstX = mLastX
        }
        mFirstY = y.toFloat()
        mPosition = pointToPosition(x, y)
        // 获取触碰点所在的position
        if (mPosition != INVALID_POSITION) {
          if (stateCallback != null) stateCallback!!.dragEnable(false)
          val view: View? = mFlingView
          // 获取触碰点所在的view
          mFlingView = getChildAt(mPosition) as ViewGroup
          // 点击的是否是同一打开的item
          isTouchOpened = mFlingView === view && mFlingView!!.scrollX != 0
          // 这里判断一下如果之前触碰的view已经打开，而当前碰到的view不是那个view则立即关闭之前的view，此处并不需要担动画没完成冲突，因为之前已经abortAnimation
          if (view != null && mFlingView !== view && view.scrollX != 0) {
            val anim = ValueAnimator
              .ofInt(view.scrollX, 0)
              .setDuration(200)

            anim.addUpdateListener { animation: ValueAnimator ->
              val curVal = animation.animatedValue as Int
              view.scrollTo(curVal, 0)
            }

            anim.start()
            view.scrollTo(0, 0)
            return true
          }
          // 这里进行了强制的要求，RecyclerView的子ViewGroup必须要有2个子view,这样菜单按钮才会有值，
          // 需要注意的是:如果不定制RecyclerView的子View，则要求子View必须要有固定的width。
          // 比如使用LinearLayout作为根布局，而content部分width已经是match_parent，此时如果菜单view用的是wrap_content，menu的宽度就会为0。
          mMenuViewWidth = if (mFlingView!!.childCount == 2) {
            mFlingView!!.getChildAt(1).width
          } else {
            INVALID_CHILD_WIDTH
          }
        }
      }

      MotionEvent.ACTION_MOVE -> {
        mVelocityTracker!!.computeCurrentVelocity(1000)
        // 此处有俩判断，满足其一则认为是侧滑：
        // 1.如果x方向速度大于y方向速度，且大于最小速度限制；
        // 2.如果x方向的侧滑距离大于y方向滑动距离，且x方向达到最小滑动距离；
        val xVelocity = mVelocityTracker!!.xVelocity
        val yVelocity = mVelocityTracker!!.yVelocity
        if (abs(xVelocity.toDouble()) > SNAP_VELOCITY && abs(xVelocity.toDouble()) > abs(yVelocity.toDouble())
          || abs((x - mFirstX).toDouble()) >= mTouchSlop
          && abs((x - mFirstX).toDouble()) > abs((y - mFirstY).toDouble())
        ) {
          mIsSlide = true

          if (stateCallback != null) stateCallback!!.dragEnable(false)
          return true
        } else {
          if (!isTouchOpened && stateCallback != null) {
            stateCallback!!.dragEnable(true)
          }
        }
      }

      MotionEvent.ACTION_UP -> releaseVelocity()
    }
    return super.onInterceptTouchEvent(e)
  }

  /**
   * 在onTouchEvent中处理事件，控制Menu的隐藏与展开。
   *
   * 首先是在ACTION_MOVE中，如果处于侧滑状态则让目标ItemView通过scrollBy()跟着手势移动，注意判断边界
   *
   * 在ACTION_UP中，此时会产生两个结果：一个是继续展开菜单，另一个是关闭菜单。这两个结果又都分了两种情况：
   *
   * 1，当松手时向左的滑动速度超过了阈值，就让目标ItemView保持松手时的速度继续展开。
   *
   * 2，当松手时向右的滑动速度超过了阈值，就让目标ItemView关闭。
   *
   * 3，当松手时移动的距离超过了隐藏的宽度的一半(也就是最大可以移动的距离的一半)，则让ItemVIew继续展开。
   *
   * 4，当松手时移动的距离小于隐藏的宽度的一半，则让ItemVIew关闭。
   */
  override fun onTouchEvent(e: MotionEvent): Boolean {
    if (mIsSlide && mPosition != INVALID_POSITION) {
      val x = e.x
      obtainVelocity(e)
      when (e.action) {
        MotionEvent.ACTION_DOWN -> {}
        MotionEvent.ACTION_MOVE ->                     // 随手指滑动
          if (mMenuViewWidth != INVALID_CHILD_WIDTH) {
            val dx = mLastX - x
            if (mFlingView!!.scrollX + dx <= mMenuViewWidth
              && mFlingView!!.scrollX + dx > 0
            ) {
              mFlingView!!.scrollBy(dx.toInt(), 0)
            }
            mLastX = x
          }

        MotionEvent.ACTION_UP -> {
          if (mMenuViewWidth != INVALID_CHILD_WIDTH) {
            val scrollX = mFlingView!!.scrollX
            mVelocityTracker!!.computeCurrentVelocity(1000)
            // 此处有两个因素决定是否打开菜单：
            // 1.菜单被拉出宽度大于菜单宽度一半；
            // 2.横向滑动速度大于最小滑动速度；
            // 注意：之所以要小于负值，是因为向左滑则速度为负值
            if (mVelocityTracker!!.xVelocity < -SNAP_VELOCITY) {
              // 向左侧滑达到侧滑最低速度，则打开
              val delt =
                abs((mMenuViewWidth - scrollX).toDouble()).toInt()
              val t = (delt / mVelocityTracker!!.xVelocity * 1000).toInt()
              mScroller.startScroll(
                scrollX, 0, mMenuViewWidth - scrollX, 0,
                abs(t.toDouble()).toInt()
              )
            } else if (mVelocityTracker!!.xVelocity >= SNAP_VELOCITY) {
              // 向右侧滑达到侧滑最低速度，则关闭
              mScroller.startScroll(
                scrollX, 0, -scrollX, 0,
                abs(scrollX.toDouble()).toInt()
              )
            } else if (scrollX >= mMenuViewWidth / 2) {
              // 如果超过删除按钮一半，则打开
              mScroller.startScroll(
                scrollX, 0, mMenuViewWidth - scrollX, 0,
                abs((mMenuViewWidth - scrollX).toDouble()).toInt()
              )
            } else {    // 其他情况则关闭
              mScroller.startScroll(
                scrollX, 0, -scrollX, 0,
                abs(scrollX.toDouble()).toInt()
              )
            }
            invalidate()
          }
          mMenuViewWidth = INVALID_CHILD_WIDTH
          mIsSlide = false
          mPosition = INVALID_POSITION
          releaseVelocity() // 这里之所以会调用，是因为如果前面拦截了，就不会执行ACTION_UP,需要在这里释放追踪
        }
      }
      return true
    } else {
      // 此处防止RecyclerView正常滑动时，还有菜单未关闭
      closeMenu()
      // Velocity，这里的释放是防止RecyclerView正常拦截了，但是在onTouchEvent中却没有被释放；
      // 有三种情况：1.onInterceptTouchEvent并未拦截，在onInterceptTouchEvent方法中，DOWN和UP一对获取和释放；
      // 2.onInterceptTouchEvent拦截，DOWN获取，但事件不是被侧滑处理，需要在这里进行释放；
      // 3.onInterceptTouchEvent拦截，DOWN获取，事件被侧滑处理，则在onTouchEvent的UP中释放。
      releaseVelocity()
    }
    return super.onTouchEvent(e)
  }

  private fun releaseVelocity() {
    if (mVelocityTracker != null) {
      mVelocityTracker!!.clear()
      mVelocityTracker!!.recycle()
      mVelocityTracker = null
    }
  }

  private fun obtainVelocity(event: MotionEvent) {
    if (mVelocityTracker == null) {
      mVelocityTracker = VelocityTracker.obtain()
    }
    mVelocityTracker!!.addMovement(event)
  }

  /**
   * 找到手指落在RV中的对应ItemView的position
   *
   * @param x 手指在屏幕触摸点的X坐标
   * @param y 手指在屏幕触摸点的Y坐标
   * @return
   */
  fun pointToPosition(x: Int, y: Int): Int {
    val frame = mTouchFrame
    val count = childCount
    for (i in count - 1 downTo 0) {
      val child = getChildAt(i)
      if (child.visibility == VISIBLE) {
        child.getHitRect(frame)
        if (frame.contains(x, y)) {
          return i
        }
      }
    }
    return INVALID_POSITION
  }

  override fun computeScroll() {
    if (mScroller.computeScrollOffset()) {
      mFlingView!!.scrollTo(mScroller.currX, mScroller.currY)
      invalidate()
    }
  }

  /**
   * 将显示子菜单的子view关闭
   * 由于RecyclerView的复用机制，需要在点击删除菜单删除Item后，让Item关闭，不然就会出现删除一个Item后往下滚动，会再出来一个已展开的Item。
   * 这里本身是要自己来实现的，但是由于不定制item，因此不好监听器点击事件，因此需要调用者手动的关闭
   */
  fun closeMenu() {
    if (mFlingView != null && mFlingView!!.scrollX != 0) {
      mFlingView!!.scrollTo(0, 0)
    }
  }

  fun setStateCallback(stateCallback: StateCallback?) {
    this.stateCallback = stateCallback
  }

  interface StateCallback {
    fun dragEnable(enable: Boolean)
  }

  companion object {
    private const val TAG = "SwipeDeleteRecyclerView"
    private const val INVALID_POSITION = -1 // 触摸到的点不在子View范围内
    private const val INVALID_CHILD_WIDTH = -1 // 子ItemView不含两个子View
    private const val SNAP_VELOCITY = 600 // 最小滑动速度
  }
}
