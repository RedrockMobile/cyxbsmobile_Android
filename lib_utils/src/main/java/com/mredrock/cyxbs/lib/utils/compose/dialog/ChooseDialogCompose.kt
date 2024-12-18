package com.mredrock.cyxbs.lib.utils.compose.dialog

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.snapshots.StateFactoryMarker
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.DialogProperties

/**
 * .
 *
 * @author 985892345
 * @date 2023/12/21 21:06
 */
@StateFactoryMarker
fun showChooseDialog(
  width: Dp = 300.dp,
  height: Dp = 180.dp,
  isTwoBtn: Boolean = true,
  btnWidth: Dp = 100.dp,
  btnHeight: Dp = 38.dp,
  positiveBtnText: String = "确定",
  negativeBtnText: String = "取消",
  priority: Int = Int.MAX_VALUE / 2,
  properties: DialogProperties = DialogProperties(),
  onDismissRequest: Dialog.() -> Unit = { hide() },
  onClickPositiveBtn: Dialog.() -> Unit = { hide() },
  onClickNegativeBtn: Dialog.() -> Unit = { hide() },
  content: @Composable () -> Unit,
) : Dialog = ChooseDialog(
  width,
  height,
  isTwoBtn,
  btnWidth,
  btnHeight,
  positiveBtnText,
  negativeBtnText,
  priority,
  properties,
  onDismissRequest,
  onClickPositiveBtn,
  onClickNegativeBtn,
  content,
).apply { show() }

internal class ChooseDialog(
  private val width: Dp,
  private val height: Dp,
  private val isTwoBtn: Boolean,
  private val btnWidth: Dp,
  private val btnHeight: Dp,
  private val positiveBtnText: String,
  private val negativeBtnText: String,
  override val priority: Int,
  override val properties: DialogProperties,
  override val onDismissRequest: Dialog.() -> Unit,
  private val onClickPositionBtn: Dialog.() -> Unit,
  private val onClickNegativeBtn: Dialog.() -> Unit,
  private val content: @Composable () -> Unit,
) : Dialog() {

  @Composable
  override fun Content() {
    Column(
      modifier = Modifier.size(width, height),
    ) {
      Box(
        modifier = Modifier
          .weight(1F)
          .fillMaxWidth()
      ) {
        content.invoke()
      }
      if (isTwoBtn) {
        TwoBtnCompose()
      } else {
        OneBtnCompose()
      }
    }
  }


  @Composable
  private fun TwoBtnCompose() {
    Row(modifier = Modifier.padding(bottom = 30.dp).fillMaxWidth()) {
      Spacer(modifier = Modifier.weight(1F))
      Box(
        modifier = Modifier,
        contentAlignment = Alignment.Center
      ) {
        NegativeBtnCompose()
      }
      Spacer(modifier = Modifier.weight(0.8F))
      Box(
        modifier = Modifier,
        contentAlignment = Alignment.Center
      ) {
        PositiveBtnCompose()
      }
      Spacer(modifier = Modifier.weight(1F))
    }
  }

  @Composable
  private fun OneBtnCompose() {
    Box(
      modifier = Modifier.padding(bottom = 30.dp).fillMaxWidth(),
      contentAlignment = Alignment.BottomCenter
    ) {
      PositiveBtnCompose()
    }
  }

  @Composable
  private fun PositiveBtnCompose() {
    Card(
      modifier = Modifier
        .width(btnWidth)
        .height(btnHeight),
//      backgroundColor = Color(0xFF4A44E4),
      shape = RoundedCornerShape(16.dp),
    ) {
      Box(
        modifier = Modifier.clickable(onClick = { onClickPositionBtn.invoke(this@ChooseDialog) }),
        contentAlignment = Alignment.Center
      ) {
        Text(text = positiveBtnText, color = Color.White)
      }
    }
  }

  @Composable
  private fun NegativeBtnCompose() {
    Card(
      modifier = Modifier
        .width(btnWidth)
        .height(btnHeight),
//      backgroundColor = Color(0xFFC3D4EE),
      shape = RoundedCornerShape(16.dp),
    ) {
      Box(
        modifier = Modifier.clickable(onClick = { onClickNegativeBtn.invoke(this@ChooseDialog) }),
        contentAlignment = Alignment.Center
      ) {
        Text(text = negativeBtnText)
      }
    }
  }
}