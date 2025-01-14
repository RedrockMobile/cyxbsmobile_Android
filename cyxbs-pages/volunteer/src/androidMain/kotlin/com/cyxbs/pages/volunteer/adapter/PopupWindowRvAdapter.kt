package com.cyxbs.pages.volunteer.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.volunteer.R

class PopupWindowRvAdapter(private var dataList: List<String>, private val onItemClick: (String) -> Unit) : RecyclerView.Adapter<PopupWindowRvAdapter.ViewHolder>() {


    inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        var tv_year: TextView
        init {
            tv_year = view.findViewById<TextView>(R.id.tv_year)
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PopupWindowRvAdapter.ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.volunteer_item_pop_window, parent, false))
    }

    override fun getItemCount(): Int {
        return dataList.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        holder.tv_year.text = holder.itemView.context.getString(R.string.volunteer_string_year, dataList[position])
        holder.itemView.setOnClickListener { onItemClick(dataList[position]) }
    }


}