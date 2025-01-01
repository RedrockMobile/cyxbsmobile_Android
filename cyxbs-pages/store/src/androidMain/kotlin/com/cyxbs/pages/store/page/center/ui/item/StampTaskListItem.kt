package com.cyxbs.pages.store.page.center.ui.item

import android.annotation.SuppressLint
import android.content.res.ColorStateList
import android.graphics.Color
import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.color
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.bean.StampCenter
import com.cyxbs.pages.store.utils.SimpleRvAdapter
import com.cyxbs.pages.store.utils.StoreType
import com.google.android.material.button.MaterialButton
import com.google.android.material.progressindicator.LinearProgressIndicator

/**
 * 自己写了个用于解耦不同的 item 的 Adapter 的封装类, 详情请看 [SimpleRvAdapter]
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2021/8/9
 */
class StampTaskListItem(
  taskMap: Map<Int, StampCenter.Task>
) : SimpleRvAdapter.VHItem<StampTaskListItem.VH, StampCenter.Task>(
  taskMap, R.layout.store_recycler_item_stamp_task_list
) {

  class VH(itemView: View) : RecyclerView.ViewHolder(itemView) {
    val storeBtnStampTaskListGo = itemView.findViewById<MaterialButton>(R.id.store_btn_stamp_task_list_go)
    val storeTvStampTaskListName = itemView.findViewById<TextView>(R.id.store_tv_stamp_task_list_name)
    val storeTvStampTaskListDescribe = itemView.findViewById<TextView>(R.id.store_tv_stamp_task_list_describe)
    val storeTvStampTaskListGainNumber = itemView.findViewById<TextView>(R.id.store_tv_stamp_task_list_gain_number)
    val storeProgressBarStampTask = itemView.findViewById<LinearProgressIndicator>(R.id.store_progress_bar_stamp_task)
    val storeTvStampTaskListProgress = itemView.findViewById<TextView>(R.id.store_tv_stamp_task_list_progress)
  }
  
  /**
   * 该方法调用了 [diffRefreshAllItemMap] 用于自动刷新
   *
   * 因为我在 Item 中整合了 DiffUtil 自动刷新, 只有你全部的 Item 都调用了 [diffRefreshAllItemMap],
   * 就会自动启动 DiffUtil
   */
  fun resetData(taskMap: Map<Int, StampCenter.Task>) {
    diffRefreshAllItemMap(
      taskMap,
      isSameName = { oldData, newData -> // 这个是判断新旧数据中 张三 是否是 张三 (可以点进去看注释)
        oldData.type == newData.type && oldData.title == newData.title && oldData.maxProgress == newData.maxProgress
      },
      isSameData = { oldData, newData ->
        oldData == newData
      })
  }
  
  private var mInitialRippleColor: ColorStateList? = null

  override fun onViewRecycled(holder: VH) {
    super.onViewRecycled(holder)
    // 当 item 被回收时就设置进度为 0, 防止因为任务过多在滑回来时而出现 item 复用时闪进度的 bug
    holder.storeProgressBarStampTask.progress = 0
  }

  override fun getNewViewHolder(itemView: View): VH {
    return VH(itemView)
  }

  override fun onCreate(holder: VH, map: Map<Int, StampCenter.Task>) {
    // 记录按钮默认的水波纹颜色, 因为后面要还原
    mInitialRippleColor = holder.storeBtnStampTaskListGo.rippleColor
    holder.storeBtnStampTaskListGo.setOnSingleClickListener { // 点击事件的跳转
      val position = holder.layoutPosition
      val task = map[position]
      if (task != null) {
        StoreType.Task.jumpOtherUi(it.context, task) // 跳转统一写在这个类里
      }
    }
  }

  @SuppressLint("SetTextI18n")
  override fun onRefactor(holder: VH, position: Int, value: StampCenter.Task) {
    holder.storeTvStampTaskListName.text = value.title
    holder.storeTvStampTaskListDescribe.text = value.description
    holder.storeTvStampTaskListGainNumber.text = "+${value.gainStamp}"
    holder.storeBtnStampTaskListGo.isClickable = value.currentProgress != value.maxProgress
    holder.storeBtnStampTaskListGo.setBackgroundColor(
      if (value.currentProgress != value.maxProgress) R.color.store_stamp_task_go_btn_bg.color
      else R.color.store_stamp_task_go_btn_bg_ok.color
    )
    holder.storeTvStampTaskListProgress.text = "${value.currentProgress}/${value.maxProgress}"
    holder.storeProgressBarStampTask.max = value.maxProgress
    holder.storeProgressBarStampTask.post { // 不加 post 就不显示进度条加载动画, 很奇怪
      holder.storeProgressBarStampTask.setProgressCompat(
        value.currentProgress, value.currentProgress != 0
      )
    }
    if (value.currentProgress != value.maxProgress) {
      if (position == 0) {
        holder.storeBtnStampTaskListGo.text = "去签到"
      } else {
        holder.storeBtnStampTaskListGo.text = "去完成"
      }
      // 因为复用的原因, 在下面设置后要还原
      holder.storeBtnStampTaskListGo.rippleColor = mInitialRippleColor
    } else {
      holder.storeBtnStampTaskListGo.text = "已完成"
      // 设置点击效果的水波纹颜色为透明, 相当于禁用水波纹
      holder.storeBtnStampTaskListGo.rippleColor = ColorStateList.valueOf(Color.TRANSPARENT)
    }
  }
}