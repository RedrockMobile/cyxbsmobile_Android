package com.cyxbs.pages.home.viewmodel

import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.runtime.MutableFloatState
import androidx.compose.runtime.Stable
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.pages.home.R
import kotlinx.collections.immutable.persistentListOf
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/4
 */
class BottomNavViewModel : BaseViewModel() {

  val discoverItem = BottomNavItem(
    R.string.home_nav_discover,
    R.drawable.home_ic_explore_selected,
    R.drawable.home_ic_explore_unselected,
    R.drawable.home_ic_explore_unselected,
  )
  val fairgroundItem = BottomNavItem(
    R.string.home_nav_fairground,
    R.drawable.home_ic_fairground_selectored,
    R.drawable.home_ic_fairground_unselectored,
    R.drawable.home_ic_fairground_unselectored,
  )
  val mineItem = BottomNavItem(
    R.string.home_nav_mine,
    R.drawable.home_ic_mine_selected,
    R.drawable.home_ic_mine_unselected,
    R.drawable.home_ic_mine_red_dot_unselected,
  )

  val items = persistentListOf(discoverItem, fairgroundItem, mineItem)

  val height: Dp = 60.dp

  val selectedItem: MutableStateFlow<BottomNavItem> = MutableStateFlow(items[0])

  val offsetYRadio: MutableFloatState = mutableFloatStateOf(0F)
  val alpha: MutableFloatState = mutableFloatStateOf(1F)

  fun select(index: Int) {
    select(items[index])
  }

  fun select(item: BottomNavItem) {
    selectedItem.value = item
  }

  @Stable
  inner class BottomNavItem(
    @StringRes val titleId: Int,
    @DrawableRes val selectedIconId: Int,
    @DrawableRes val unselectedIconId: Int,
    @DrawableRes val unselectedRedDotIconId: Int,
  ) {
    val title = appContext.getString(titleId)

    private val redDot = MutableStateFlow(false)

    fun setRedDot(has: Boolean) {
      if (has && selectedItem.value === this) return // 如果已经处于选中状态，则不显示红点
      redDot.value = has
    }

    fun observerRedDot() = redDot.asStateFlow()
  }
}