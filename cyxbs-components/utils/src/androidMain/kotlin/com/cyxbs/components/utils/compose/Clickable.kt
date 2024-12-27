package com.cyxbs.components.utils.compose

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.IndicationNodeFactory
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.interaction.FocusInteraction
import androidx.compose.foundation.interaction.HoverInteraction
import androidx.compose.foundation.interaction.InteractionSource
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.interaction.PressInteraction
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.ContentDrawScope
import androidx.compose.ui.node.DelegatableNode
import androidx.compose.ui.node.DrawModifierNode
import androidx.compose.ui.node.invalidateDraw
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch

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
  interactionSource = remember { MutableInteractionSource() },
  indication = null,
  enabled = enabled,
  onClickLabel = onClickLabel,
  role = role,
  onClick = onClick
)

@Composable
fun Modifier.clickableCardIndicator(
  radius: Dp = 8.dp,
  enabled: Boolean = true,
  onClickLabel: String? = null,
  role: Role? = null,
  onClick: () -> Unit
) = clickable(
  interactionSource = remember { MutableInteractionSource() },
  indication = CardIndicationMap.getOrPut(radius) { CardIndicationNodeFactory(radius) },
  enabled = enabled,
  onClickLabel = onClickLabel,
  role = role,
  onClick = onClick
)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun Modifier.combineClickableCardIndicator(
  radius: Dp = 8.dp,
  enabled: Boolean = true,
  onClickLabel: String? = null,
  role: Role? = null,
  onLongClickLabel: String? = null,
  onLongClick: (() -> Unit)? = null,
  onDoubleClick: (() -> Unit)? = null,
  onClick: () -> Unit
) = combinedClickable(
  interactionSource = remember { MutableInteractionSource() },
  indication = CardIndicationMap.getOrPut(radius) { CardIndicationNodeFactory(radius) },
  enabled = enabled,
  onClickLabel = onClickLabel,
  role = role,
  onLongClickLabel = onLongClickLabel,
  onLongClick = onLongClick,
  onDoubleClick = onDoubleClick,
  onClick = onClick,
)

private val CardIndicationMap = hashMapOf<Dp, CardIndicationNodeFactory>()

private data class CardIndicationNodeFactory(val radius: Dp) : IndicationNodeFactory {

  override fun create(interactionSource: InteractionSource): DelegatableNode =
    DefaultDebugIndicationInstance(interactionSource, radius)

  class DefaultDebugIndicationInstance(
    private val interactionSource: InteractionSource,
    private val radius: Dp,
  ) : Modifier.Node(), DrawModifierNode {
    private var isPressed = false
    private var isHovered = false
    private var isFocused = false
    override fun onAttach() {
      coroutineScope.launch {
        var pressCount = 0
        var hoverCount = 0
        var focusCount = 0
        interactionSource.interactions.collect { interaction ->
          when (interaction) {
            is PressInteraction.Press -> pressCount++
            is PressInteraction.Release -> pressCount--
            is PressInteraction.Cancel -> pressCount--
            is HoverInteraction.Enter -> hoverCount++
            is HoverInteraction.Exit -> hoverCount--
            is FocusInteraction.Focus -> focusCount++
            is FocusInteraction.Unfocus -> focusCount--
          }
          val pressed = pressCount > 0
          val hovered = hoverCount > 0
          val focused = focusCount > 0
          var invalidateNeeded = false
          if (isPressed != pressed) {
            isPressed = pressed
            invalidateNeeded = true
          }
          if (isHovered != hovered) {
            isHovered = hovered
            invalidateNeeded = true
          }
          if (isFocused != focused) {
            isFocused = focused
            invalidateNeeded = true
          }
          if (invalidateNeeded) invalidateDraw()
        }
      }
    }

    override fun ContentDrawScope.draw() {
      drawContent()
      if (isPressed) {
        drawRoundRect(
          color = Color.Black.copy(alpha = 0.3f),
          size = size,
          cornerRadius = CornerRadius(radius.toPx())
        )
      } else if (isHovered || isFocused) {
        drawRoundRect(
          color = Color.Black.copy(alpha = 0.1f),
          size = size,
          cornerRadius = CornerRadius(radius.toPx())
        )
      }
    }
  }
}