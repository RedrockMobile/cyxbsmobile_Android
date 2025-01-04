package com.cyxbs.components.utils.compose

import androidx.compose.foundation.clickable
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role

/**
 * .
 *
 * @author 985892345
 * @date 2024/2/19 19:38
 */

/**
 * 点击不带虚影的 clickable
 */
@Composable
fun Modifier.clickableNoIndicator(
  enabled: Boolean = true,
  onClickLabel: String? = null,
  role: Role? = null,
  onClick: () -> Unit
) = clickable(
  interactionSource = null,
  indication = null,
  enabled = enabled,
  onClickLabel = onClickLabel,
  role = role,
  onClick = onClick
)
