package com.cyxbs.components.utils.compose

import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.unit.DpSize
import androidx.compose.ui.unit.dp

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/1
 */

@Composable
actual fun getWindowScreenSize(): DpSize {
  return LocalConfiguration.current.let {
    DpSize(it.screenWidthDp.dp, it.screenHeightDp.dp)
  }
}