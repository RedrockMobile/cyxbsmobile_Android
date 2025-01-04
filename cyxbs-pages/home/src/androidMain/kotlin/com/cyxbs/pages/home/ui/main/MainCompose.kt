package com.cyxbs.pages.home.ui.main

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
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.unit.times
import androidx.compose.ui.util.fastForEach
import androidx.compose.ui.viewinterop.AndroidView
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.viewpager2.widget.ViewPager2
import com.cyxbs.components.config.compose.theme.AppTheme
import com.cyxbs.components.utils.extensions.color
import com.cyxbs.pages.home.R
import com.cyxbs.pages.home.adapter.MainAdapter
import com.cyxbs.pages.home.ui.course.HomeCourseCompose
import com.cyxbs.pages.home.viewmodel.BottomNavViewModel
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
@Composable
fun MainPage() {
  AppTheme {
    Box(
      modifier = Modifier.fillMaxSize()
    ) {
      HomeViewPagerCompose()
      HomeCourseCompose()
      HomeNavCompose(modifier = Modifier.align(Alignment.BottomCenter))
    }
  }
}

@Composable
private fun HomeViewPagerCompose(modifier: Modifier = Modifier) {
  val bottomNavViewModel = viewModel(BottomNavViewModel::class)
  val coroutineScope = rememberCoroutineScope()
  AndroidView(
    modifier = modifier
      .fillMaxSize()
      .navigationBarsPadding()
      .padding(bottom = bottomNavViewModel.height),
    factory = { context ->
      ViewPager2(context).apply {
        id = R.id.home_view_pager_id // 这里需要赋值 id，否则 ViewPager2 不会使用系统重建的 Fragment
        adapter = MainAdapter(context as FragmentActivity)
        isUserInputEnabled = false
        bottomNavViewModel.selectedItem.map {
          bottomNavViewModel.items.indexOf(it)
        }.onEach {
          currentItem = it
        }.launchIn(coroutineScope)
      }
    }
  )
}

@Composable
private fun HomeNavCompose(modifier: Modifier = Modifier) {
  val bottomNavViewModel = viewModel(BottomNavViewModel::class)
  val shadowElevation by bottomNavViewModel.selectedItem.map {
    if (it === bottomNavViewModel.discoverItem || it === bottomNavViewModel.mineItem) 0.dp else 4.dp
  }.collectAsState(0.dp)
  Row(
    modifier = modifier
      .navigationBarsPadding()
      .height(bottomNavViewModel.height)
      .fillMaxWidth()
      .shadow(shadowElevation)
      .offset {
        IntOffset(
          x = 0,
          y = (bottomNavViewModel.offsetYRadio.floatValue * bottomNavViewModel.height).roundToPx()
        )
      }
      .graphicsLayer {
        alpha = bottomNavViewModel.alpha.floatValue
      }
      .background(Color(com.cyxbs.components.config.R.color.config_common_background_color.color)),
    horizontalArrangement = Arrangement.SpaceAround,
    verticalAlignment = Alignment.CenterVertically,
  ) {
    bottomNavViewModel.items.fastForEach {
      HomeNavItemCompose(it)
    }
  }
}

@Composable
private fun HomeNavItemCompose(item: BottomNavViewModel.BottomNavItem, modifier: Modifier = Modifier) {
  val bottomNavViewModel = viewModel(BottomNavViewModel::class)
  val coroutineScope = rememberCoroutineScope()
  val selected by bottomNavViewModel.selectedItem.map { it === item }.collectAsState(false)
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
            bottomNavViewModel.select(item)
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
    bottomNavViewModel.selectedItem.map { it === item }.distinctUntilChanged().collect {
      if (!it) {
        scale.animateTo(1F) // 取消选中时还原动画
      }
    }
  }
}
