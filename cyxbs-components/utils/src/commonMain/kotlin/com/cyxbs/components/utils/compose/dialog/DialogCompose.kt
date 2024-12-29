package com.cyxbs.components.utils.compose.dialog

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import kotlinx.coroutines.CoroutineScope

/**
 * .
 *
 * @author 985892345
 * @date 2023/12/22 10:41
 */

fun showDialog(
  priority: Int = Int.MAX_VALUE / 2,
  properties: DialogProperties = DialogProperties(),
  onDismissRequest: Dialog.() -> Unit = { hide() },
  content: @Composable () -> Unit,
) {
  object : Dialog() {
    override val priority: Int
      get() = priority
    override val properties: DialogProperties
      get() = properties
    override val onDismissRequest: Dialog.() -> Unit
      get() = onDismissRequest

    @Composable
    override fun Content(): Unit = content.invoke()
  }.show()
}

@Stable
abstract class Dialog {
  abstract val priority: Int
  abstract val properties: DialogProperties
  abstract val onDismissRequest: Dialog.() -> Unit

  @Composable
  abstract fun Content()

  fun show() {
    if (AppDialogState === Empty) {
      AppDialogState = this
    } else {
      if (AppDialogState === this) return
      var l = 0
      var r = AppDialogList.size - 1
      while (l <= r) {
        val half = (l + r) ushr 1
        val dialog = AppDialogList[half]
        if (dialog.priority < priority) {
          l = half + 1
        } else {
          r = half - 1
        }
      }
      AppDialogList[l] = this
    }
  }

  fun hide() {
    if (AppDialogState === this) {
      AppDialogState = AppDialogList.removeLastOrNull() ?: Empty
      return
    }
    AppDialogList.remove(this)
  }

  companion object {
    val Empty = object : Dialog() {
      override val priority: Int = Int.MAX_VALUE / 2
      override val properties: DialogProperties = DialogProperties()
      override val onDismissRequest: Dialog.() -> Unit = { hide() }

      @Composable
      override fun Content() = Unit
    }
  }
}

private val AppDialogList = mutableListOf<Dialog>()

private var AppDialogState: Dialog by mutableStateOf(Dialog.Empty)

private var AppDialogCoroutineScope: CoroutineScope? = null

@Composable
fun DialogCompose() {
  AppDialogCoroutineScope = rememberCoroutineScope()
  if (AppDialogState != Dialog.Empty) {
    Dialog(
      properties = AppDialogState.properties,
      onDismissRequest = {
        AppDialogState.onDismissRequest.invoke(AppDialogState)
      }
    ) {
      Box(
        modifier = Modifier
          .wrapContentSize()
          .clip(RoundedCornerShape(16.dp))
          .background(Color(0xFFFAFAFA)),
      ) {
        AppDialogState.Content()
      }
    }
  }
}