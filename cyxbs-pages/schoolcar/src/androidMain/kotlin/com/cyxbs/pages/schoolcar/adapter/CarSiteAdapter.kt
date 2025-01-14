package com.cyxbs.pages.schoolcar.adapter

import android.content.Context
import android.graphics.Color
import android.os.Build
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.RequiresApi
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.schoolcar.bean.Station
import com.cyxbs.pages.schoolcar.R
import java.util.*

/**
 *@Author:SnowOwlet
 *@Date:2022/5/7 16:55
 *
 */
class CarSiteAdapter(val context: Context, var stations: List<Station>, val lineId: Int) :
  RecyclerView.Adapter<CarSiteAdapter.ViewHolder>() {
  private val checks = BooleanArray(stations.size).apply { Arrays.fill(this, false) }

  companion object {
    val END_VIEW = 0
    val START_VIEW = 1
    val COMMON_VIEW = 2
  }

  class ViewHolder(
    itemView: View,
    ivRes: Int,
    tvRes: Int
  ) : RecyclerView.ViewHolder(itemView) {
    val iv: ImageView = itemView.findViewById(ivRes)
    val tv: TextView = itemView.findViewById(tvRes)
  }

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    return when (viewType) {
      START_VIEW ->
        ViewHolder(
          LayoutInflater.from(context)
            .inflate(R.layout.schoolcar_item_carsite_start, parent, false),
          R.id.schoolcar_item_iv_car_site_start,
          R.id.schoolcar_item_tv_car_site_start
        )
      END_VIEW ->
        ViewHolder(
          LayoutInflater.from(context)
            .inflate(R.layout.schoolcar_item_carsite_end, parent, false),
          R.id.schoolcar_item_iv_car_site_end,
          R.id.schoolcar_item_tv_car_site_end
        )
      else ->
        ViewHolder(
          LayoutInflater.from(context).inflate(R.layout.schoolcar_item_carsite, parent, false),
          R.id.schoolcar_item_iv_car_site,
          R.id.schoolcar_item_tv_car_site
        )
    }
  }

  @RequiresApi(Build.VERSION_CODES.M)
  override fun onBindViewHolder(holder: ViewHolder, position: Int) {
    val type = getItemViewType(position)
    holder.tv.text = stations[position].name
    if (type != COMMON_VIEW){
    when(type) {
      START_VIEW -> holder.iv.setImageResource(R.drawable.schoolcar_car_site_line_first)
      END_VIEW -> holder.iv.setImageResource(R.drawable.schoolcar_car_site_line_last)
      }
      if (checks[position]) {
        holder.tv.setTextColor(Color.parseColor(getTextColor(lineId)))
      } else {
        holder.tv.setTextColor(context.getColor(R.color.schoolcar_site_text))
      }
//        holder.itemView.setOnClickListener {
//          Arrays.fill(checks,false)
//          checks[position] = true
//          notifyDataSetChanged()
//        }
    } else {
      if (checks[position]) {
        holder.iv.setImageResource(R.drawable.schoolcar_car_site_line_select)
        holder.tv.setTextColor(Color.parseColor(getTextColor(lineId)))
      } else {
        holder.iv.setImageResource(R.drawable.schoolcar_car_site_line)
        holder.tv.setTextColor(context.getColor(R.color.schoolcar_site_text))
      }
//        holder.itemView.setOnClickListener {
//          Arrays.fill(checks,false)
//          checks[position] = true
//          notifyDataSetChanged()
//        }
    }
  }

  override fun getItemCount(): Int = stations.size

  override fun getItemViewType(position: Int): Int {
    return when (position) {
      0 -> START_VIEW
      stations.size - 1 -> END_VIEW
      else -> COMMON_VIEW
    }
  }

  fun choose(id: Int) {
    Arrays.fill(checks, false)
    checks[id] = true
    notifyDataSetChanged()
  }

  fun clear() {
    Arrays.fill(checks, false)
    notifyDataSetChanged()
  }

  private fun getTextColor(lineId: Int): String =
    when (lineId) {
      0 -> "#FF45B9"
      1 -> "#FF8015"
      2 -> "#06A3FC"
      3 -> "#18D19A"
      else -> "#6F6AFF"
    }
}
