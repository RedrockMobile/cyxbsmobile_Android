package com.cyxbs.pages.map.util

import androidx.compose.ui.util.fastForEachReversed


/**
 * 移植 dataBinding 中的 ObservableArrayList
 *
 * @author 985892345
 * @date 2025/1/2
 */
class ObservableArrayList<T> : ArrayList<T>() {

  private var mListeners = mutableListOf<OnListChangedCallback<T>>()

  fun addOnListChangedCallback(listener: OnListChangedCallback<T>) {
    mListeners.add(listener)
  }

  fun removeOnListChangedCallback(listener: OnListChangedCallback<*>) {
    mListeners.remove(listener)
  }

  override fun add(element: T): Boolean {
    super.add(element)
    notifyAdd(size - 1, 1)
    return true
  }

  override fun add(index: Int, element: T) {
    super.add(index, element)
    notifyAdd(index, 1)
  }

  override fun addAll(elements: Collection<T>): Boolean {
    val oldSize = size
    val added = super.addAll(elements)
    if (added) {
      notifyAdd(oldSize, size - oldSize)
    }
    return added
  }

  override fun addAll(index: Int, elements: Collection<T>): Boolean {
    val added = super.addAll(index, elements)
    if (added) {
      notifyAdd(index, elements.size)
    }
    return added
  }

  override fun clear() {
    val oldSize = size
    super.clear()
    if (oldSize != 0) {
      notifyRemove(0, oldSize)
    }
  }

  override fun removeAt(index: Int): T {
    val `val` = super.removeAt(index)
    notifyRemove(index, 1)
    return `val`
  }

  override fun remove(element: T): Boolean {
    val index = indexOf(element)
    if (index >= 0) {
      removeAt(index)
      return true
    } else {
      return false
    }
  }

  override fun set(index: Int, element: T): T {
    val `val` = super.set(index, element)
    mListeners.fastForEachReversed { it.onItemRangeChanged(this, index, 1) }
    return `val`
  }

  override fun removeRange(fromIndex: Int, toIndex: Int) {
    super.removeRange(fromIndex, toIndex)
    notifyRemove(fromIndex, toIndex - fromIndex)
  }

  private fun notifyAdd(start: Int, count: Int) {
    mListeners.fastForEachReversed { it.onItemRangeInserted(this, start, count) }
  }

  private fun notifyRemove(start: Int, count: Int) {
    mListeners.fastForEachReversed { it.onItemRangeRemoved(this, start, count) }
  }

  abstract class OnListChangedCallback<T> {

    /**
     * Called whenever one or more items in the list have changed.
     * @param sender The changing list.
     * @param positionStart The starting index that has changed.
     * @param itemCount The number of items that have changed.
     */
    abstract fun onItemRangeChanged(sender: ObservableArrayList<T>, positionStart: Int, itemCount: Int)

    /**
     * Called whenever items have been inserted into the list.
     * @param sender The changing list.
     * @param positionStart The insertion index
     * @param itemCount The number of items that have been inserted
     */
    abstract fun onItemRangeInserted(sender: ObservableArrayList<T>, positionStart: Int, itemCount: Int)

    /**
     * Called whenever items in the list have been deleted.
     * @param sender The changing list.
     * @param positionStart The starting index of the deleted items.
     * @param itemCount The number of items removed.
     */
    abstract fun onItemRangeRemoved(sender: ObservableArrayList<T>, positionStart: Int, itemCount: Int)
  }
}