package com.cyxbs.pages.store.page.record.ui.item

import android.annotation.SuppressLint
import android.view.View
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.utils.SimpleRvAdapter
import com.cyxbs.pages.store.bean.ExchangeRecord
import com.cyxbs.pages.store.page.record.ui.activity.ExchangeDetailActivity
import com.cyxbs.pages.store.utils.Date

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @data 2021/8/29
 */
class ExchangePageItem(
    list: List<ExchangeRecord>,
    startPosition: Int
) : SimpleRvAdapter.VHItem<ExchangePageItem.VH, ExchangeRecord>(
    list,
    startPosition,
    R.layout.store_recycler_item_record_exchange
) {

    class VH(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val storeLayoutExchangeRecord = itemView.findViewById<View>(R.id.store_layout_exchange_record)
        val storeItemExchangeRecordTvEvent = itemView.findViewById<TextView>(R.id.store_item_exchange_record_tv_event)
        val storeItemExchangeRecordTvCount = itemView.findViewById<TextView>(R.id.store_item_exchange_record_tv_count)
        val storeItemExchangeRecordTvDate = itemView.findViewById<TextView>(R.id.store_item_exchange_record_tv_date)
        val storeBtnProductReceiveTips = itemView.findViewById<View>(R.id.store_btn_product_receive_tips)
    }

    /**
     * 用于传入新数据使用差分刷新
     */
    fun refresh(list: List<ExchangeRecord>, startPosition: Int) {
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

    override fun onCreate(holder: VH, map: Map<Int, ExchangeRecord>) {
        holder.storeLayoutExchangeRecord.setOnSingleClickListener {
            ExchangeDetailActivity.activityStart(
                holder.itemView.context,
                map.getValue(holder.layoutPosition)
            )
        }
    }

    @SuppressLint("SetTextI18n")
    override fun onRefactor(holder: VH, position: Int, value: ExchangeRecord) {
        holder.storeItemExchangeRecordTvEvent.text = value.goodsName
        holder.storeItemExchangeRecordTvCount.text = value.goodsPrice.toString()
        holder.storeItemExchangeRecordTvDate.text = Date.getTime(value.date)

        // 先默认隐藏 如果未领取就加载动画
        holder.storeBtnProductReceiveTips.alpha = 0F
        if (!value.isReceived) {
            holder.storeBtnProductReceiveTips.animate()
                .alpha(1F)
                .setDuration(600)
                .start()
        }
    }

    override fun onViewRecycled(holder: VH) {
        super.onViewRecycled(holder)
        // 当 item 被回收时调用, 取消动画效果, 防止因复用而出现闪动
        holder.storeBtnProductReceiveTips.animate().cancel()
        holder.storeBtnProductReceiveTips.alpha = 0F
    }
}