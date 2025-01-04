package com.cyxbs.components.config.compose.theme

import androidx.compose.foundation.Indication
import androidx.compose.foundation.LocalIndication
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.text.font.FontFamily

@Composable
internal actual fun ConfigAppTheme(
  darkTheme: Boolean,
  content: @Composable () -> Unit
) {
  CompositionLocalProvider(
    LocalIndication provides NoIndication, // 安卓上不显示默认的点击效果
  ) {
    content()
  }
}

@Composable
internal actual fun getFontFamily(): FontFamily {
  return FontFamily.Default
}

private object NoIndication : Indication
