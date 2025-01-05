package com.cyxbs.components.config.compose.theme

import androidx.compose.runtime.ProvidableCompositionLocal
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.graphics.Color

/**
 * 应用级别最常用的颜色
 *
 * @author 985892345
 * @date 2024/1/28 11:09
 */

val LocalAppColors: ProvidableCompositionLocal<AppColor> = staticCompositionLocalOf {
  error("未配置 AppTheme")
}

open class AppColor(
  val tvLv1: Color = Color(0xFF112C54),
  val tvLv2: Color = Color(0xFF112C57),
  val tvLv3: Color = Color(0xFF15315B),
  val tvLv4: Color = Color(0xFF2A4E84),
  val whiteBlack: Color = Color.White,
  val positive: Color = Color(0xFF4A44E4),
  val negative: Color = Color(0xFFC3D4EE),
) {
  companion object : AppColor()
}

object AppDarkColor : AppColor(
  tvLv1 = Color(0xFFFFFFFF),
  tvLv2 = Color(0xFFFFFFFF),
  tvLv3 = Color(0xFFFFFFFF),
  tvLv4 = Color(0xFFFFFFFF),
  whiteBlack = Color.Black,
  positive = Color(0xFF4A44E4),
  negative = Color(0xCC5A5A5A),
)