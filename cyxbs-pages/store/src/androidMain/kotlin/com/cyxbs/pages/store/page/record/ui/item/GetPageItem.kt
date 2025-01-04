package com.cyxbs.pages.store.page.record.ui.item

import android.annotation.SuppressLint
import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.bean.StampGetRecord
import com.cyxbs.pages.store.utils.Date
import com.cyxbs.pages.store.utils.SimpleRvAdapter

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @data 2021/8/29
 */
class GetPageItem(
    list: List<StampGetRecord>,
    startPosition: Int
) : SimpleRvAdapter.VHItem<GetPageItem.VH, StampGetRecord>(
    list,
    startPosition,
    R.layout.store_recycler_item_record_get
) {

    class VH(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val storeItemGetRecordTvEvent = itemView.findViewById<TextView>(R.id.store_item_get_record_tv_event)
        val storeItemGetRecordTvCount = itemView.findViewById<TextView>(R.id.store_item_get_record_tv_count)
        val storeItemGetRecordTvDate = itemView.findViewById<TextView>(R.id.store_item_get_record_tv_date)
    }

    /**
     * 用于传入新数据使用差分刷新
     */
    fun refresh(list: List<StampGetRecord>, startPosition: Int) {
        diffRefreshAllItemMap(list, startPosition,
            isSameName = { oldData, newData ->
                oldData.date == newData.date
            },
            isSameData = { oldData, newData ->
                oldData == newData
            }
        )
    }

    override fun getNewViewHolder(itemView: View): VH {
        return VH(itemView)
    }

    override fun onCreate(holder: VH, map: Map<Int, StampGetRecord>) {
    }

    @SuppressLint("SetTextI18n")
    override fun onRefactor(holder: VH, position: Int, value: StampGetRecord) {
        holder.storeItemGetRecordTvEvent.text = value.taskName
        holder.storeItemGetRecordTvCount.text = "+${value.taskIncome}"
        holder.storeItemGetRecordTvDate.text = Date.getTime(value.date)
    }
}