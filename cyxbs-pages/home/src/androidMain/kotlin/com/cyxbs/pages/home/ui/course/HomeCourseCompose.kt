package com.cyxbs.pages.home.ui.course

import android.widget.FrameLayout
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.Image
import androidx.compose.foundation.basicMarquee
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.compose.ui.viewinterop.NoOpUpdate
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.commit
import com.cyxbs.pages.home.R
import com.cyxbs.pages.home.ui.course.utils.CourseHeaderHelper
import com.cyxbs.pages.course.api.ICourseService
import com.cyxbs.components.config.route.COURSE_POS_TO_MAP
import com.cyxbs.components.config.route.DISCOVER_MAP
import com.mredrock.cyxbs.lib.base.crash.CrashDialog
import com.mredrock.cyxbs.lib.base.utils.Umeng
import com.mredrock.cyxbs.lib.utils.compose.BottomSheetState
import com.mredrock.cyxbs.lib.utils.compose.clickableNoIndicator
import com.mredrock.cyxbs.lib.utils.extensions.color
import com.mredrock.cyxbs.lib.utils.extensions.colorCompose
import com.mredrock.cyxbs.lib.utils.extensions.drawable
import com.mredrock.cyxbs.lib.utils.service.ServiceManager
import com.mredrock.cyxbs.lib.utils.service.impl
import kotlinx.coroutines.launch
import kotlin.math.max

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/15
 */

/*
 * 展开时：
 * 课表主体:     0.0 --------> 1.0
 * 课表头部:     0.0 -> 0.0 -> 1.0
 * 主界面头部:   1.0 -> 0.0 -> 0.0
 *
 * 折叠时：
 * 课表主体:     1.0 --------> 0.0
 * 课表头部:     1.0 -> 0.0 -> 0.0
 * 主界面头部:   0.0 -> 0.0 -> 1.0
 * */

@Composable
fun HomeCourseCompose(modifier: Modifier = Modifier) {
//  val bottomSheetState = rememberBottomSheetState(
//    peekHeight = BottomNavState.height + 70.dp
//  )
//  BottomSheetCompose(
//    bottomSheetState = bottomSheetState,
//    modifier = modifier
//      .fillMaxSize()
//      .statusBarsPadding(),
//  ) {
//    HomeCourseHeaderCompose(
//      bottomSheetState = bottomSheetState,
//      modifier = Modifier.bottomSheetDraggable()
//    )
//    HomeCourseContainerCompose(
//      bottomSheetState = bottomSheetState
//    )
//  }
  // Compose 与原生的嵌套滑动存在问题，OffsetInWindow 始终为 0，
  // 导致 NestedScrollView ACTION_MOVE 中的 mLastMotionY = y - scrollOffset 不被正确计算
  // 所以这里需要等到课表的 Scroll 变成 Compose 后再进行 BottomSheet 的迁移
  AndroidView(
    modifier = modifier.fillMaxSize().systemBarsPadding(),
    factory = {
      HomeCourseLayout(it, null)
    }
  )
}

@Composable
fun HomeCourseContainerCompose(
  bottomSheetState: BottomSheetState,
  modifier: Modifier = Modifier,
) {
  val courseService = remember { ICourseService::class.impl }
  AndroidView(
    modifier = modifier.fillMaxSize(),
    factory = {
      val activity = it as FragmentActivity
      FrameLayout(it).apply {
        id = R.id.home_course_container_id
        activity.supportFragmentManager.commit {
          replace(id, courseService.createHomeCourseFragment())
        }
        background = com.cyxbs.pages.course.widget.R.drawable.course_widget_layer_list_course_bg.drawable
        isNestedScrollingEnabled = true
      }
    },
    update = {
      val fraction = bottomSheetState.fraction
      courseService.setCourseVpAlpha(fraction)
      courseService.setHeaderAlpha(max(fraction * 2 - 1, 0F))
      courseService.setBottomSheetSlideOffset(fraction)
    },
    onReset = NoOpUpdate, // 开启复用
  )
}

@Composable
private fun HomeCourseHeaderCompose(
  bottomSheetState: BottomSheetState,
  modifier: Modifier = Modifier,
) {
  val coroutineScope = rememberCoroutineScope()
//  val header by CourseHeaderHelper.observeHeader()
//    .distinctUntilChanged()
//    .asFlow()
//    .collectAsState(null)
  val header: CourseHeaderHelper.Header = remember { CourseHeaderHelper.HintHeader("test") }
  Box(
    modifier = modifier
      .fillMaxWidth()
      .height(70.dp)
      .graphicsLayer {
        val fraction = bottomSheetState.fraction
        alpha = max(1 - fraction * 2, 0F)
      }
      .clickableNoIndicator {
        coroutineScope.launch {
          bottomSheetState.expand()
        }
      }
  ) {
    when (val tempHeader = header) {
      is CourseHeaderHelper.HintHeader -> CourseHintHeaderCompose(tempHeader)
      is CourseHeaderHelper.ShowHeader -> CourseShowHeaderCompose(tempHeader)
      null -> Unit
    }
  }
}

@OptIn(ExperimentalFoundationApi::class)
@Composable
private fun CourseHintHeaderCompose(
  header: CourseHeaderHelper.HintHeader,
  modifier: Modifier = Modifier,
) {
  Box(modifier = modifier.fillMaxSize()) {
    Text(
      modifier = Modifier
        .align(Alignment.BottomCenter)
        .padding(bottom = 6.dp)
        .combinedClickable(
          interactionSource = null,
          indication = null,
          onLongClick = {
            if (header.throwable != null) {
              CrashDialog.Builder(header.throwable).show()
            }
          },
          onClick = {}
        ),
      text = if (header.throwable == null) header.hint else "发生异常，长按显示",
      color = com.cyxbs.components.config.R.color.config_level_four_font_color.colorCompose,
    )
  }
}

@Composable
private fun CourseShowHeaderCompose(
  header: CourseHeaderHelper.ShowHeader,
  modifier: Modifier = Modifier,
) {
  val context = LocalContext.current
  Row(modifier = modifier.fillMaxSize(), verticalAlignment = Alignment.Bottom) {
    Column(
      modifier = Modifier
        .weight(1F)
        .padding(start = 16.dp, end = 8.dp, bottom = 2.dp)
    ) {
      Text(
        text = header.state,
        color = com.cyxbs.components.config.R.color.config_level_four_font_color.colorCompose,
        fontSize = 8.sp
      )
      Text(
        modifier = Modifier
          .basicMarquee()
          .clickable(
            interactionSource = null,
            indication = null
          ) {
            when (header.item) {
              is CourseHeaderHelper.AffairItem -> {
                ICourseService::class.impl.openBottomSheetDialogByAffair(
                  context,
                  header.item.affair
                )
              }

              is CourseHeaderHelper.LessonItem -> {
                ICourseService::class.impl.openBottomSheetDialogByLesson(
                  context,
                  header.item.lesson
                )
                // Umeng 埋点统计
                Umeng.sendEvent(Umeng.Event.CourseDetail(true))
              }
            }
          },
        text = header.title,
        color = com.cyxbs.components.config.R.color.config_level_two_font_color.color.colorCompose,
        fontSize = 22.sp,
        fontWeight = FontWeight.Bold,
      )
    }
    Row(modifier = Modifier.padding(bottom = 6.dp)) {
      Image(
        painter = painterResource(R.drawable.home_ic_course_header_time),
        contentDescription = header.time,
        modifier = Modifier.padding(end = 5.dp)
      )
      Text(
        modifier = Modifier,
        text = header.time,
      )
    }
    Row(
      modifier = Modifier
        .weight(1F)
        .padding(start = 8.dp, end = 16.dp, bottom = 6.dp)
        .clickable(interactionSource = null, indication = null) {
          if (header.item is CourseHeaderHelper.LessonItem) {
            // 跳转至地图界面
            ServiceManager.activity(DISCOVER_MAP) {
              withString(COURSE_POS_TO_MAP, header.content)
            }
          }
        },
      horizontalArrangement = Arrangement.End
    ) {
      if (header.item is CourseHeaderHelper.LessonItem) {
        Image(
          painter = painterResource(R.drawable.home_ic_course_header_landmark),
          contentDescription = header.time,
          modifier = Modifier.padding(end = 5.dp)
        )
      }
      Text(
        modifier = Modifier.basicMarquee(),
        text = header.time,
      )
    }
  }
}
