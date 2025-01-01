package com.cyxbs.pages.store.page.record.ui.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.bean.ExchangeRecord
import com.cyxbs.pages.store.utils.Date
import kotlin.math.abs

/**
 *    author : zz
 *    e-mail : 1140143252@qq.com
 *    date   : 2021/8/4 11:39
 */
class ExchangeDetailActivity : BaseActivity() {

    companion object {
        fun activityStart(context: Context, data: ExchangeRecord) {
            val intent = Intent(context, ExchangeDetailActivity::class.java)
            intent.putExtra(ExchangeDetailActivity::data.name, data)
            context.startActivity(intent)
        }
    }

    private val data by intent<ExchangeRecord>()

    private val storeTvExchangeDetailOrder by R.id.store_tv_exchange_detail_order.view<TextView>()
    private val storeExchangeDetailProductName by R.id.store_exchange_detail_product_name.view<TextView>()
    private val storeExchangeDetailProductPrice by R.id.store_exchange_detail_product_price.view<TextView>()
    private val storeIvExchangeOrderBg by R.id.store_iv_exchange_order_bg.view<ImageView>()
    private val storeExchangeDetailState by R.id.store_exchange_detail_state.view<TextView>()
    private val storeExchangeDetailTime by R.id.store_exchange_detail_time.view<TextView>()
    private val storeIvToolbarArrowLeft by R.id.store_iv_toolbar_no_line_arrow_left.view<View>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.store_activity_exchange_detail)
        initView()
    }

    @SuppressLint("SetTextI18n")
    private fun initView() {
        storeTvExchangeDetailOrder.text = data.orderId.toString()
        storeExchangeDetailProductName.text = data.goodsName
        storeExchangeDetailProductPrice.text = "${abs(data.goodsPrice)}邮票"
        //判断是否领取 动态改变IV TV
        if (data.isReceived) {
            storeIvExchangeOrderBg.setImageResource(R.drawable.store_ic_bg_claimed_exchange_order)
            storeExchangeDetailState.text = "已领取"
        } else {
            storeIvExchangeOrderBg.setImageResource(R.drawable.store_ic_bg_unclaimed_exchange_order)
            storeExchangeDetailState.text = "待领取"
        }
        //设置时间
        storeExchangeDetailTime.text = Date.getExactTime(data.date)

        //设置左上角返回点击事件
        storeIvToolbarArrowLeft.setOnSingleClickListener {
            finish()
        }
    }
}