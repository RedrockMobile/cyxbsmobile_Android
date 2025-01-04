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
  val red: Color = Color(0xFFD50000),
  val blue: Color = Color(0xFF1C71FF),
  val green: Color = Color(0xFF00C853),
  val yellow: Color = Color(0xFFFFAB00),
  val orange : Color = Color(0xFFFF6D00),
) {
  companion object : AppColor()
}

object AppDarkColor : AppColor(
  tvLv1 = Color(0xFFFFFFFF),
  tvLv2 = Color(0xFFFFFFFF),
  tvLv3 = Color(0xFFFFFFFF),
  tvLv4 = Color(0xFFFFFFFF),
  whiteBlack = Color.Black,
)