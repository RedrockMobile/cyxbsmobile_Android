package com.cyxbs.pages.grades.utils.baseRv

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.PointF
import android.view.View
import androidx.annotation.ColorInt
import java.lang.Math.*
import kotlin.math.cos
import kotlin.math.sin

//********************************
//* 绘制开发工具
//********************************

/**
 * 创建画笔
 */
@JvmOverloads
internal fun <T : View> T.createPaint(colorString: String? = null, @ColorInt color: Int? = null): Paint {
    return Paint().apply {
        this.utilReset(colorString, color)
    }
}

/**
 * 自定义画笔重置方法
 */
@JvmOverloads
internal fun Paint.utilReset(colorString: String? = null, @ColorInt color: Int? = null) {
    this.reset()
    //这里默认值使用白色，可处理掉系统渲染抗锯齿时，人眼可观察到像素颜色
    this.color = color ?: Color.parseColor(colorString ?: "#FFFFFF")
    this.isAntiAlias = true
    this.style = Paint.Style.FILL
    this.strokeWidth = 0f
}

/**
 * 扩展获取绘制文字时在x轴上 垂直居中的y坐标
 */
internal fun Paint.getCenteredY(): Float {
    return this.fontSpacing / 2 - this.fontMetrics.bottom
}

/**
 * 扩展获取绘制文字时在x轴上 贴紧x轴的上边缘的y坐标
 */
internal fun Paint.getBottomedY(): Float {
    return -this.fontMetrics.bottom
}

/**
 * 扩展获取绘制文字时在x轴上 贴近x轴的下边缘的y坐标
 */
internal fun Paint.getToppedY(): Float {
    return -this.fontMetrics.ascent
}

/**
 * dp转px
 */
internal fun Context.dp2px(dpValue: Float): Float {
    if (dpValue == 0f) return 0f
    val scale = resources.displayMetrics.density
    return (dpValue * scale + 0.5f)
}

//********************************
//* 绘制辅助工具
//********************************

/**
 * 辅助绿幕背景
 */
internal fun Canvas.helpGreenCurtain(debug: Boolean) {
    if (debug) {
        this.drawColor(Color.GREEN)
    }
}

//********************************
//* 属性计算工具
//********************************

/**
 * Flags基本操作 FlagSet是否包含Flag
 */
internal fun Int.containsFlag(flag: Int): Boolean {
    return this or flag == this
}

/**
 * Flags基本操作 向FlagSet添加Flag
 */
internal fun Int.addFlag(flag: Int): Int {
    return this or flag
}

/**
 * Flags基本操作 FlagSet移除Flag
 */
internal fun Int.removeFlag(flag: Int): Int {
    return this and (flag.inv())
}

/**
 * 角度制转弧度制
 */
private fun Float.degree2radian(): Float {
    return (this / 180f * PI).toFloat()
}

/**
 * 计算某角度的sin值
 */
internal fun Float.degreeSin(): Float {
    return sin(this.degree2radian())
}

/**
 * 计算某角度的cos值
 */
internal fun Float.degreeCos(): Float {
    return cos(this.degree2radian())
}

/**
 * 计算一个点坐标，绕原点旋转一定角度后的坐标
 */
internal fun PointF.degreePointF(outPointF: PointF, degree: Float) {
    outPointF.x = this.x * degree.degreeCos() - this.y * degree.degreeSin()
    outPointF.y = this.x * degree.degreeSin() + this.y * degree.degreeCos()
}