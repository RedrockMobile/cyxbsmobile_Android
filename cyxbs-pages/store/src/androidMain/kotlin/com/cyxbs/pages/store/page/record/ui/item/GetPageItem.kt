package com.cyxbs.pages.store.page.record.ui.item

import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.utils.SimpleRvAdapter
import com.cyxbs.pages.store.bean.StampGetRecord
import com.cyxbs.pages.store.databinding.StoreRecyclerItemRecordGetBinding
import com.cyxbs.pages.store.utils.Date

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @data 2021/8/29
 */
class GetPageItem(
    list: List<StampGetRecord>,
    startPosition: Int
) : SimpleRvAdapter.DBItem<StoreRecyclerItemRecordGetBinding, StampGetRecord>(
    list,
    startPosition,
    R.layout.store_recycler_item_record_get
) {

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

    override fun onCreate(
        binding: StoreRecyclerItemRecordGetBinding,
        holder: SimpleRvAdapter.BindingVH,
        map: Map<Int, StampGetRecord>
    ) {
    }

    override fun onRefactor(
        binding: StoreRecyclerItemRecordGetBinding,
        holder: SimpleRvAdapter.BindingVH,
        position: Int,
        value: StampGetRecord
    ) {
        binding.data = value
        //单独处理时间
        binding.storeItemGetRecordTvDate.text = Date.getTime(value.date)
    }
}