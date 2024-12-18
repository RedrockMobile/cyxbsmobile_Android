package com.cyxbs.pages.home.ui.main

import androidx.annotation.DrawableRes
import androidx.annotation.StringRes
import androidx.compose.animation.core.Animatable
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.MutableFloatState
import androidx.compose.runtime.Stable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.unit.times
import androidx.compose.ui.util.fastForEach
import androidx.compose.ui.viewinterop.AndroidView
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.widget.ViewPager2
import com.cyxbs.pages.home.R
import com.cyxbs.pages.home.adapter.MainAdapter
import com.cyxbs.pages.home.ui.course.HomeCourseCompose
import com.mredrock.cyxbs.lib.utils.extensions.appContext
import com.mredrock.cyxbs.lib.utils.extensions.color
import kotlinx.collections.immutable.persistentListOf
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.launch

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/15
 */

@Stable
object BottomNavState {

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
  class BottomNavItem(
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

@Composable
fun MainCompose() {
  Box(
    modifier = Modifier.fillMaxSize()
  ) {
    HomeViewPagerCompose()
    HomeCourseCompose()
    HomeNavCompose(modifier = Modifier.align(Alignment.BottomCenter))
  }
}

@Composable
private fun HomeViewPagerCompose(modifier: Modifier = Modifier) {
  val coroutineScope = rememberCoroutineScope()
  AndroidView(
    modifier = modifier
      .fillMaxSize()
      .statusBarsPadding() // 如果后续 vp 子页面需要显示到状态栏时再重新设计
      .padding(bottom = BottomNavState.height),
    factory = { context ->
      ViewPager2(context).apply {
        adapter = MainAdapter(context as FragmentActivity)
        isUserInputEnabled = false
        BottomNavState.selectedItem.map {
          BottomNavState.items.indexOf(it)
        }.onEach {
          currentItem = it
        }.launchIn(coroutineScope)
      }
    }
  )
}

@Composable
private fun HomeNavCompose(modifier: Modifier = Modifier) {
  val shadowElevation by BottomNavState.selectedItem.map {
    if (it === BottomNavState.discoverItem || it === BottomNavState.mineItem) 0.dp else 4.dp
  }.collectAsState(0.dp)
  Row(
    modifier = modifier
      .navigationBarsPadding()
      .height(BottomNavState.height)
      .fillMaxWidth()
      .shadow(shadowElevation)
      .offset {
        IntOffset(
          x = 0,
          y = (BottomNavState.offsetYRadio.floatValue * BottomNavState.height).roundToPx()
        )
      }
      .graphicsLayer {
        alpha = BottomNavState.alpha.floatValue
      }
      .background(Color(com.mredrock.cyxbs.config.R.color.config_common_background_color.color)),
    horizontalArrangement = Arrangement.SpaceAround,
    verticalAlignment = Alignment.CenterVertically,
  ) {
    BottomNavState.items.fastForEach {
      HomeNavItemCompose(it)
    }
  }
}

@Composable
private fun HomeNavItemCompose(item: BottomNavState.BottomNavItem, modifier: Modifier = Modifier) {
  val coroutineScope = rememberCoroutineScope()
  val selected by BottomNavState.selectedItem.map { it === item }.collectAsState(false)
  val hasRedDot by item.observerRedDot().collectAsState()
  val scale = remember { Animatable(initialValue = 1F) }
  Column(
    modifier = modifier
      .pointerInput(Unit) {
        detectTapGestures(
          onPress = {
            scale.animateTo(0.9F)
            tryAwaitRelease()
            scale.animateTo(1F)
          },
          onTap = {
            coroutineScope.launch { scale.animateTo(1.1F) }
            BottomNavState.select(item)
            if (hasRedDot) {
              item.setRedDot(false)
            }
          },
        )
      }
      .padding(horizontal = 8.dp, vertical = 4.dp)
      .graphicsLayer {
        scaleX = scale.value
        scaleY = scaleX
      },
    horizontalAlignment = Alignment.CenterHorizontally,
  ) {
    Image(
      modifier = Modifier.size(26.dp),
      painter = painterResource(
        if (selected) item.selectedIconId
        else if (hasRedDot) item.unselectedRedDotIconId
        else item.unselectedIconId
      ),
      contentDescription = item.title,
    )
    Text(
      modifier = Modifier.padding(top = 2.dp),
      text = item.title,
      color = if (selected) Color(R.color.home_btn_bottom_focused.color)
      else Color(R.color.home_btn_bottom_un_focused.color),
      fontSize = 10.sp,
    )
  }
  LaunchedEffect(item) {
    BottomNavState.selectedItem.map { it === item }.distinctUntilChanged().collect {
      if (!it) {
        scale.animateTo(1F) // 取消选中时还原动画
      }
    }
  }
}
