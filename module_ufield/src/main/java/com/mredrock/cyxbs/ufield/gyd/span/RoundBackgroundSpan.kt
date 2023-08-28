package com.mredrock.cyxbs.ufield.gyd.span

import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.RectF
import android.text.style.ReplacementSpan

/**
 * description ： TODO:类的作用
 * author : 苟云东
 * email : 2191288460@qq.com
 * date : 2023/8/24 19:42
 */
class RoundBackgroundSpan(
    private val backgroundColor: Int,
    private val backgroundPadding: Float,
    private val cornerRadius: Float,
    private val textColor: Int
) : ReplacementSpan() {

    override fun getSize(paint: Paint, text: CharSequence?, start: Int, end: Int, fm: Paint.FontMetricsInt?): Int {
        return (paint.measureText(text, start, end) + backgroundPadding * 2).toInt()
    }

    override fun draw(
        canvas: Canvas, text: CharSequence?, start: Int, end: Int,
        x: Float, top: Int, y: Int, bottom: Int, paint: Paint
    ) {
        val textWidth = paint.measureText(text, start, end)
        val textHeight = bottom - top

        val backgroundWidth = textWidth + backgroundPadding * 2
        val backgroundRight = x + backgroundWidth
        val backgroundTop = top.toFloat()
        val backgroundBottom = bottom.toFloat()

        val textX = x + backgroundPadding
        val textY = y.toFloat()

        paint.color = backgroundColor
        canvas.drawRoundRect(
            RectF(x, backgroundTop, backgroundRight, backgroundBottom),
            cornerRadius, cornerRadius, paint
        )

        paint.color = textColor
        canvas.drawText(text!!, start, end, textX, textY, paint)
    }
}