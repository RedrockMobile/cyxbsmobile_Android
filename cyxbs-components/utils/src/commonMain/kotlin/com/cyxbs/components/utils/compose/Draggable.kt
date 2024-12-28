package com.cyxbs.components.utils.compose

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.ui.ExperimentalComposeUiApi
import androidx.compose.ui.Modifier
import androidx.compose.ui.node.DelegatingNode
import androidx.compose.ui.node.ModifierNodeElement

/**
 * .
 *
 * @author 985892345
 * @date 2024/2/28 21:50
 */

/**
 * 反射 scrollable 使桌面端支持鼠标点击滚动
 */
@Stable
@Composable
fun Modifier.reflexScrollableForMouse(
): Modifier = then(ReflexScrollableCanDragElement())

private class ReflexScrollableCanDragElement : ModifierNodeElement<ReflexScrollableCanDragNode>() {
  override fun create(): ReflexScrollableCanDragNode {
    return ReflexScrollableCanDragNode()
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other !is ReflexScrollableCanDragElement) return false
    return true
  }

  override fun hashCode(): Int {
    return 429480
  }

  override fun update(node: ReflexScrollableCanDragNode) {
    node.reflex()
  }
}

private class ReflexScrollableCanDragNode : DelegatingNode() {
  @OptIn(ExperimentalComposeUiApi::class)
  override fun onAttach() {
    super.onAttach()
    sideEffect {
      reflex()
    }
  }

  fun reflex() {
//    reflexScrollableCanDrag(this)
  }
}

//internal expect fun reflexScrollableCanDrag(node: Modifier.Node)