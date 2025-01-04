package com.cyxbs.pages.store.page.center.ui.item

import android.annotation.SuppressLint
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.utils.extensions.setImageFromUrl
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.bean.StampCenter
import com.cyxbs.pages.store.page.exchange.ui.activity.ProductExchangeActivity
import com.cyxbs.pages.store.utils.SimpleRvAdapter

/**
 * 自己写了个用于解耦不同的 item 的 Adapter 的封装类, 详情请看 [SimpleRvAdapter]
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2021/8/9
 */
class SmallShopProductItem(
  shopMap: HashMap<Int, StampCenter.Shop>,
  private var stampCount: Int
) : SimpleRvAdapter.VHItem<SmallShopProductItem.VH, StampCenter.Shop>(
  shopMap, R.layout.store_recycler_item_small_shop_product
) {

  class VH(itemView: View) : RecyclerView.ViewHolder(itemView) {
    val storeCvStampSmallShop = itemView.findViewById<View>(R.id.store_cv_stamp_small_shop)
    val storeIvSmallShopProduct = itemView.findViewById<ImageView>(R.id.store_iv_small_shop_product)
    val storeTvSmallShopProductName = itemView.findViewById<TextView>(R.id.store_tv_small_shop_product_name)
    val storeTvSmallShopProductStock = itemView.findViewById<TextView>(R.id.store_tv_small_shop_product_stock)
    val storeTvSmallShopPrice = itemView.findViewById<TextView>(R.id.store_tv_small_shop_price)
  }
  
  /**
   * 该方法调用了 [diffRefreshAllItemMap] 用于自动刷新
   *
   * 因为我在 Item 中整合了 DiffUtil 自动刷新, 只有你全部的 Item 都调用了 [diffRefreshAllItemMap],
   * 就会自动启动 DiffUtil
   */
  fun resetData(shopMap: HashMap<Int, StampCenter.Shop>, stampCount: Int) {
    this.stampCount = stampCount
    
    diffRefreshAllItemMap(
      shopMap,
      isSameName = { oldData, newData ->
        oldData.id == newData.id // 这个是判断新旧数据中 张三 是否是 张三 (可以点进去看注释)
      },
      isSameData = { oldData, newData ->
        oldData == newData // 这个是判断其他数据是否相等
      })
  }

  override fun getNewViewHolder(itemView: View): VH {
    return VH(itemView)
  }

  override fun onCreate(holder: VH, map: Map<Int, StampCenter.Shop>) {
    //设置跳转到兑换界面
    holder.storeCvStampSmallShop.setOnSingleClickListener {
      val shop = map[holder.layoutPosition]
      if (shop != null) {
        ProductExchangeActivity.activityStart(it.context, shop.id, stampCount, shop.isPurchased)
      }
    }
  }

  @SuppressLint("SetTextI18n")
  override fun onRefactor(holder: VH, position: Int, value: StampCenter.Shop) {
    holder.storeIvSmallShopProduct.setImageFromUrl(value.url)
    holder.storeTvSmallShopProductName.text = value.title
    holder.storeTvSmallShopProductStock.text = "库存: ${value.amount}"
    holder.storeTvSmallShopPrice.text = "${value.price}"
  }
}