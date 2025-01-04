package com.cyxbs.components.config.compose.theme

import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import cyxbsmobile.cyxbs_components.config.generated.resources.Res
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Bold
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_ExtraLight
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Heavy
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Light
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Medium
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Normal
import cyxbsmobile.cyxbs_components.config.generated.resources.SourceHanSansCN_Regular
import org.jetbrains.compose.resources.Font

@Composable
internal actual fun ConfigAppTheme(
  darkTheme: Boolean,
  content: @Composable () -> Unit
) {
  CompositionLocalProvider(
    LocalAppDark provides false, // 网页端暂时不开启黑夜模式
    LocalAppColors provides AppColor,
  ) {
    content()
  }
}

@Composable
internal actual fun getFontFamily(): FontFamily = FontFamily(
  Font(
    Res.font.SourceHanSansCN_ExtraLight,
    FontWeight.ExtraLight,
  ),
  Font(
    Res.font.SourceHanSansCN_Light,
    FontWeight.Light,
  ),
  Font(
    Res.font.SourceHanSansCN_Normal,
    FontWeight.Normal,
  ),
  Font(
    Res.font.SourceHanSansCN_Regular,
    FontWeight.Medium,
  ),
  Font(
    Res.font.SourceHanSansCN_Medium,
    FontWeight.SemiBold,
  ),
  Font(
    Res.font.SourceHanSansCN_Bold,
    FontWeight.Bold,
  ),
  Font(
    Res.font.SourceHanSansCN_Heavy,
    FontWeight.ExtraBold,
  ),
)