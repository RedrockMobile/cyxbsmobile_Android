package com.cyxbs.components.utils.extensions

import kotlin.contracts.ExperimentalContracts
import kotlin.contracts.InvocationKind
import kotlin.contracts.contract

/**
 * .
 *
 * @author 985892345
 * 2023/3/1 14:53
 */

@OptIn(ExperimentalContracts::class)
inline fun String?.ifNull(action: () -> Unit): Boolean {
  contract { callsInPlace(action, InvocationKind.EXACTLY_ONCE) }
  return if (this != null) false else {
    action.invoke()
    true
  }
}

@OptIn(ExperimentalContracts::class)
inline fun String?.ifNullOrEmpty(action: () -> Unit): Boolean {
  contract { callsInPlace(action, InvocationKind.EXACTLY_ONCE) }
  return if (!this.isNullOrEmpty()) false else {
    action.invoke()
    true
  }
}

@OptIn(ExperimentalContracts::class)
inline fun String?.ifNullOrBlank(action: () -> Unit): Boolean {
  contract { callsInPlace(action, InvocationKind.EXACTLY_ONCE) }
  return if (!this.isNullOrBlank()) false else {
    action.invoke()
    true
  }
}

/**
 * 遍历每行并替换
 */
fun CharSequence.replaceLine(action: (lineIndex: Int, old: String) -> String): String {
  val oldList = split("\n")
  val newList = arrayListOf<String>()
  oldList.forEachIndexed { index, old ->
    val new = action.invoke(index, old)
    if (new.isNotEmpty()) {
      newList.add(new)
    }
  }
  return newList.joinToString(separator = "\n")
}