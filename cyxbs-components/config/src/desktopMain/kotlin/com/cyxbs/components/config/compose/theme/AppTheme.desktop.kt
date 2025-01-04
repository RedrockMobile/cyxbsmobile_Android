package com.cyxbs.components.config.compose.theme

import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.text.font.FontFamily

@Composable
internal actual fun ConfigAppTheme(
  darkTheme: Boolean,
  content: @Composable () -> Unit
) {
  CompositionLocalProvider(
    LocalAppDark provides false, // 桌面端暂时不开启黑夜模式
    LocalAppColors provides AppColor,
  ) {
    content()
  }
}

@Composable
internal actual fun getFontFamily(): FontFamily {
  return FontFamily.Default
}