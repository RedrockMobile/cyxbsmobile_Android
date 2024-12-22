package com.mredrock.cyxbs.lib.utils.extensions

import android.graphics.drawable.Drawable
import android.view.animation.Animation
import android.view.animation.AnimationUtils
import androidx.annotation.DimenRes
import androidx.appcompat.content.res.AppCompatResources
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.core.content.ContextCompat
import kotlin.math.roundToInt

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email guo985892345@foxmail.com
 * @date 2022/8/4 11:28
 */

val Int.dp2pxF: Float
  get() = appContext.resources.displayMetrics.density * this

val Int.dp2px: Int
  get() = dp2pxF.toInt()

val Float.dp2pxF: Float
  get() = appContext.resources.displayMetrics.density * this

val Float.dp2px: Int
  get() = dp2pxF.toInt()

val Int.px2dpF: Float
  get() = this / appContext.resources.displayMetrics.density

val Int.px2dp: Int
  get() = px2dpF.toInt()

val Int.px2dpCompose: Dp
  @Composable
  get() = LocalDensity.current.run { toDp() }

val Float.px2dpF: Float
  get() = this / appContext.resources.displayMetrics.density

val Float.px2dp: Int
  get() = px2dpF.toInt()

val Float.px2dpCompose: Dp
  @Composable
  get() = LocalDensity.current.run { toDp() }

val Int.dp2spF: Float
  get() = appContext.resources.displayMetrics.scaledDensity * this

val Int.dp2sp: Int
  get() = (dp2spF * this).roundToInt()

val Float.dp2spF: Float
  get() = appContext.resources.displayMetrics.scaledDensity * this

val Float.dp2sp: Int
  get() = (dp2spF * this).roundToInt()

val Int.sp2dpF: Float
  get() = this / appContext.resources.displayMetrics.scaledDensity

val Int.sp2dp: Int
  get() = (sp2dpF * this).roundToInt()

val Float.sp2dpF: Float
  get() = this / appContext.resources.displayMetrics.scaledDensity

val Float.sp2dp: Int
  get() = (sp2dpF * this).roundToInt()

val Dp.px: Float
  @Composable
  get() = LocalDensity.current.run { toPx() }

val Int.color: Int
  get() = ContextCompat.getColor(appContext, this)

val Int.colorCompose: Color
  @Composable
  get() = Color(ContextCompat.getColor(LocalContext.current, this))

val Int.string: String
  get() = appContext.getString(this)

val Int.stringCompose: String
  @Composable
  get() = LocalContext.current.getString(this)

val Int.drawable: Drawable
  get() = AppCompatResources.getDrawable(appContext, this)!!

val Int.drawableCompose: Drawable
  @Composable
  get() = AppCompatResources.getDrawable(LocalContext.current, this)!!

val Int.dimen: Float
  get() = appContext.resources.getDimension(this)

val Int.dimenCompose: Float
  @Composable
  get() = LocalContext.current.resources.getDimension(this)

val Int.anim: Animation
  get() = AnimationUtils.loadAnimation(appContext, this)

val screenWidth: Int
  get() = appContext.resources.displayMetrics.widthPixels

val screenHeight: Int
  get() = appContext.resources.displayMetrics.heightPixels