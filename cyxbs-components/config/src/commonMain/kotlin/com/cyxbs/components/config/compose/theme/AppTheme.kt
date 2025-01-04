package com.cyxbs.components.config.compose.theme

import androidx.compose.foundation.IndicationNodeFactory
import androidx.compose.foundation.LocalIndication
import androidx.compose.foundation.interaction.FocusInteraction
import androidx.compose.foundation.interaction.HoverInteraction
import androidx.compose.foundation.interaction.InteractionSource
import androidx.compose.foundation.interaction.PressInteraction
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Shapes
import androidx.compose.material.Typography
import androidx.compose.material.darkColors
import androidx.compose.material.lightColors
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.CornerRadius
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.ContentDrawScope
import androidx.compose.ui.node.DelegatableNode
import androidx.compose.ui.node.DrawModifierNode
import androidx.compose.ui.node.invalidateDraw
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.TextUnit
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/4
 */

@Composable
fun AppTheme(
  darkTheme: Boolean = isSystemInDarkTheme(),
  content: @Composable () -> Unit,
) {
  MaterialTheme(
    colors = if (!darkTheme) LightColor else DarkColor,
    typography = createTypography(),
    shapes = Shapes,
  ) {
    CompositionLocalProvider(
      LocalAppDark provides darkTheme,
      LocalAppColors provides if (!darkTheme) AppColor else AppDarkColor,
      LocalIndication provides CardIndicationNodeFactory,
    ) {
      ConfigAppTheme(
        darkTheme = darkTheme,
        content = content,
      )
    }
  }
}

private val LightColor = lightColors(
  background = Color(0xFFF2F3F8)
)

private val DarkColor = darkColors(
)

@Composable
internal expect fun ConfigAppTheme(darkTheme: Boolean, content: @Composable () -> Unit)

@Composable
internal expect fun getFontFamily(): FontFamily

@Composable
private fun createTypography() : Typography {
  val defaultFontFamily = getFontFamily()
  return Typography(
    // 去掉字体的默认行高间距
    h1 = MaterialTheme.typography.h1.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    h2 = MaterialTheme.typography.h2.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    h3 = MaterialTheme.typography.h3.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    h4 = MaterialTheme.typography.h4.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    h5 = MaterialTheme.typography.h5.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    h6 = MaterialTheme.typography.h6.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    subtitle1 = MaterialTheme.typography.subtitle1.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    subtitle2 = MaterialTheme.typography.subtitle2.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    body1 = MaterialTheme.typography.body1.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    body2 = MaterialTheme.typography.body2.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    button = MaterialTheme.typography.button.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    caption = MaterialTheme.typography.caption.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
    overline = MaterialTheme.typography.overline.copy(lineHeight = TextUnit.Unspecified, fontFamily = defaultFontFamily),
  )
}

private val Shapes = Shapes(
  medium = RoundedCornerShape(8.dp),
  large = RoundedCornerShape(16.dp),
)


private data object CardIndicationNodeFactory : IndicationNodeFactory {

  override fun create(interactionSource: InteractionSource): DelegatableNode =
    DefaultDebugIndicationInstance(interactionSource, radius = 4.dp)

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
          color = Color.Black.copy(alpha = 0.2f),
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