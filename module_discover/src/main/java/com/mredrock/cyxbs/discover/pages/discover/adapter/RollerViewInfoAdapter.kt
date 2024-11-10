package com.mredrock.cyxbs.discover.pages.discover.adapter

import android.view.ViewGroup
import android.widget.ImageView
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.imageview.ShapeableImageView
import com.google.android.material.shape.ShapeAppearanceModel
import com.mredrock.cyxbs.api.account.IAccountService
import com.mredrock.cyxbs.discover.R
import com.mredrock.cyxbs.discover.network.RollerViewInfo
import com.mredrock.cyxbs.discover.pages.RollerViewActivity
import com.mredrock.cyxbs.lib.utils.extensions.dp2pxF
import com.mredrock.cyxbs.lib.utils.extensions.processLifecycleScope
import com.mredrock.cyxbs.lib.utils.extensions.setOnSingleClickListener
import com.mredrock.cyxbs.lib.utils.logger.TrackingUtils
import com.mredrock.cyxbs.lib.utils.logger.event.ClickEvent
import com.mredrock.cyxbs.lib.utils.service.impl
import kotlinx.coroutines.launch

/**
 * Banner adapter
 *
 * @author 985892345
 * @date 2024/11/10
 */
class RollerViewInfoAdapter(
  val list: List<RollerViewInfo>
) : RecyclerView.Adapter<RollerViewInfoAdapter.VHolder>() {
  inner class VHolder(val iv: ShapeableImageView) : RecyclerView.ViewHolder(iv) {
    init {
      iv.setOnSingleClickListener {
        if (IAccountService::class.impl.getVerifyService().isLogin()) {
          // banner位的点击埋点
          processLifecycleScope.launch {
            TrackingUtils.trackClickEvent(ClickEvent.CLICK_YLC_BANNER_ENTRY)
          }
        }
        val data = list[layoutPosition]
        if (data.picture_goto_url.startsWith("http")) {
          RollerViewActivity.startRollerViewActivity(data, iv.context)
        }
      }
    }
  }

  override fun onCreateViewHolder(
    parent: ViewGroup,
    viewType: Int
  ): VHolder {
    return VHolder(
      ShapeableImageView(parent.context).apply {
        layoutParams = ViewGroup.LayoutParams(
          ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT
        )
        val radius = 8.dp2pxF
        shapeAppearanceModel = ShapeAppearanceModel.builder()
          .setTopLeftCornerSize(radius)
          .setTopRightCornerSize(radius)
          .setBottomLeftCornerSize(radius)
          .setBottomRightCornerSize(radius)
          .build()
        scaleType = ImageView.ScaleType.CENTER_CROP
      }
    )
  }

  override fun onBindViewHolder(
    holder: VHolder,
    position: Int
  ) {
    val data = list[position]
    Glide.with(holder.iv)
      .load(data.picture_url)
      .placeholder(R.drawable.discover_ic_cyxbsv6)
      .error(R.drawable.discover_ic_cyxbsv6)
      .into(holder.iv)
  }

  override fun getItemCount(): Int = list.size
}