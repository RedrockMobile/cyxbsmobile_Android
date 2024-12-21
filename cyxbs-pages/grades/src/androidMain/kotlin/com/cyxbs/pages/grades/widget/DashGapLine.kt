package com.cyxbs.pages.grades.widget

import android.content.Context
import android.graphics.Color
import android.graphics.DashPathEffect
import android.graphics.Paint
import android.graphics.Path
import android.util.AttributeSet
import android.view.View
import com.mredrock.cyxbs.lib.utils.extensions.dp2px
import com.mredrock.cyxbs.lib.utils.extensions.dp2pxF

class DashGapLine(
  context: Context,
  attrs: AttributeSet
) : View(context, attrs) {

  private val mWidth = 100 //默认的
  private val mHeight = 100

  private val radius = 7.dp2px

  private var lineVisible = true
  private val defaultCircleColor = Color.parseColor("#2921D1")
  private val defaultGapColor = Color.parseColor("#2921D1")

  private var circle = Paint(Paint.ANTI_ALIAS_FLAG).apply {
    color = defaultCircleColor
    strokeWidth = 5.dp2pxF
    style = Paint.Style.STROKE
  }
  private var gap = Paint(Paint.ANTI_ALIAS_FLAG).apply {
    color = defaultGapColor
    strokeWidth = 3f
    style = Paint.Style.STROKE
    setPathEffect(DashPathEffect(floatArrayOf(15f, 15f), 0f))
  }
  private var mPath = Path()

  fun setLineVisible(lineVisible: Boolean) {
    this.lineVisible = lineVisible
    invalidate()
  }

  override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
    super.onMeasure(widthMeasureSpec, heightMeasureSpec)

    val widthSize = MeasureSpec.getSize(widthMeasureSpec)
    val heightSize = MeasureSpec.getSize(heightMeasureSpec)

    if (layoutParams.width == android.view.ViewGroup.LayoutParams.WRAP_CONTENT && layoutParams.height == android.view.ViewGroup.LayoutParams.WRAP_CONTENT) {
      setMeasuredDimension(
        mWidth + paddingLeft + paddingRight,
        mHeight + paddingBottom + paddingTop
      )
    } else if (layoutParams.width == android.view.ViewGroup.LayoutParams.WRAP_CONTENT) {
      setMeasuredDimension(mWidth + paddingLeft + paddingRight, heightSize)
    } else if (layoutParams.height == android.view.ViewGroup.LayoutParams.WRAP_CONTENT) {
      setMeasuredDimension(widthSize, mHeight + paddingBottom + paddingTop)
    }
  }

  override fun onDraw(canvas: android.graphics.Canvas) {
    super.onDraw(canvas)
    //draw circle
    val centerX = width / 2
    //stroke为5，所以说要加上
    canvas.drawCircle(
      centerX.toFloat(), radius + 5.dp2pxF, radius.toFloat(),
      circle
    )
    //draw gap
    if (lineVisible) {
      mPath.reset()
      mPath.moveTo(centerX.toFloat(), (radius * 2 + 11).toFloat())
      mPath.lineTo(centerX.toFloat(), height.toFloat())
      canvas.drawPath(mPath, gap)
    }
  }
}

