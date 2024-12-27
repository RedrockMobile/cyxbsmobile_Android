package com.cyxbs.components.utils.compose

import androidx.compose.runtime.Composable
import androidx.compose.runtime.staticCompositionLocalOf
import androidx.compose.ui.graphics.Color

/**
 * .
 *
 * @author 985892345
 * @date 2024/1/23 15:12
 */


val LocalAppDarkTheme = staticCompositionLocalOf { false }
val LocalAppColors = staticCompositionLocalOf<AppColor> { AppLightColor }

fun Int.color(): Color {
  return Color(this)
}

fun Long.color(): Color {
  return Color(this)
}

@Composable
fun Color.dark(darkColor: Color): Color {
  return if (LocalAppDarkTheme.current) darkColor else this
}

sealed class AppColor(
  val tvLv1: Color = Color(0xFF112C54),
  val tvLv2: Color = Color(0xFF112C57),
  val tvLv3: Color = Color(0xFF15315B),
  val tvLv4: Color = Color(0xFF2A4E84),
  val red: Color = Color(0xFFD50000),
  val blue: Color = Color(0xFF1C71FF),
  val green: Color = Color(0xFF00C853),
  val yellow: Color = Color(0xFFFFAB00),
  val orange : Color = Color(0xFFFF6D00),
)

data object AppLightColor : AppColor()

data object AppDarkColor : AppColor(
  tvLv1 = Color(0xFFFFFFFF),
  tvLv2 = Color(0xFFFFFFFF),
  tvLv3 = Color(0xFFFFFFFF),
  tvLv4 = Color(0xFFFFFFFF),
)