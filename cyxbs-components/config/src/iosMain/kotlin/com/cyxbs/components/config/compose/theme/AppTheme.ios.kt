package com.cyxbs.components.config.compose.theme

import androidx.compose.runtime.Composable
import androidx.compose.ui.text.font.FontFamily

@Composable
internal actual fun ConfigAppThemeBefore(content: @Composable () -> Unit) {
  content()
}

@Composable
internal actual fun ConfigAppThemeAfter(content: @Composable () -> Unit) {
  content()
}

@Composable
internal actual fun getFontFamily(): FontFamily {
  return FontFamily.Default
}