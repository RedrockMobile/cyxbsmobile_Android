package com.cyxbs.components.utils.compose

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

/**
 * .
 *
 * @author 985892345
 * @date 2024/1/23 15:12
 */

fun Int.color(): Color {
  return Color(this)
}

fun Long.color(): Color {
  return Color(this)
}

@Composable
fun Int.dark(darkColor: Int): Color {
  // todo
  return Color(this)
}

@Composable
fun Int.dark(darkColor: Color): Color {
  // todo
  return Color(this)
}

@Composable
fun Long.dark(darkColor: Long): Color {
  // todo
  return Color(this)
}

@Composable
fun Long.dark(darkColor: Color): Color {
  // todo
  return Color(this)
}