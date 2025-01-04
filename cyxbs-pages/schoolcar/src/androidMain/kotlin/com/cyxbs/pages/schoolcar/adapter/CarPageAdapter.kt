package com.cyxbs.pages.schoolcar.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.schoolcar.R
import com.cyxbs.pages.schoolcar.bean.Line

/**
 *@Author:SnowOwlet
 *@Date:2022/5/11 21:45
 *
 */
class CarPageAdapter(val context: Context?, val lines:List<Line>): RecyclerView.Adapter<CarPageAdapter.ViewHolder>() {

  inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
    val rv = itemView.findViewById<RecyclerView>(R.id.school_car_detail_site_rv).apply {
      this.layoutManager = LinearLayoutManager(context).apply {
        orientation = LinearLayoutManager.HORIZONTAL
      }
    }
    val schoolCarDetailIv = itemView.findViewById<ImageView>(R.id.school_car_detail_iv)
    val schoolCarDetailCardLineTvType = itemView.findViewById<TextView>(R.id.school_car_detail_card_line_tv_type)
    val schoolCarDetailCardRunTvType = itemView.findViewById<TextView>(R.id.school_car_detail_card_run_tv_type)
    val schoolCarDetailTvTime = itemView.findViewById<TextView>(R.id.school_car_detail_tv_time)
    val schoolCarDetailTvTitle = itemView.findViewById<TextView>(R.id.school_car_detail_tv_title)
  }

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    val view = LayoutInflater.from(parent.context).inflate(R.layout.schoolcar_item_car_page,parent,false)
    return ViewHolder(view)
  }

  override fun onBindViewHolder(holder: ViewHolder, position: Int) {
    val line = lines[position]
    holder.rv.adapter = CarPageSiteAdapter(context, line.stations,line.id)
    holder.apply {
      schoolCarDetailIv.setImageResource(getIcon(line.id))
      schoolCarDetailCardLineTvType.text = line.sendType
      schoolCarDetailCardRunTvType.text = line.runType
      schoolCarDetailTvTime.text = "运行时间: ${line.runTime}"
      schoolCarDetailTvTitle.text = line.name
    }
  }

  override fun getItemCount(): Int = lines.size

  private fun getIcon(id:Int):Int{
    return when(id+1){
      1-> R.drawable.schoolcar_car_icon_1
      2-> R.drawable.schoolcar_car_icon_2
      3-> R.drawable.schoolcar_car_icon_3
      4-> R.drawable.schoolcar_car_icon_4
      else -> R.drawable.schoolcar_car_icon_1
    }
  }
}