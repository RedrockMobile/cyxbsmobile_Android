package com.cyxbs.pages.store.page.exchange.ui.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.ImageButton
import android.widget.TextView
import androidx.core.app.ActivityOptionsCompat
import androidx.core.util.Pair
import com.cyxbs.components.base.dailog.BaseChooseDialog
import com.cyxbs.components.base.dailog.ChooseDialog
import com.cyxbs.components.base.pages.PhotoViewerActivity
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.base.ui.viewModelBy
import com.cyxbs.components.utils.extensions.color
import com.cyxbs.components.utils.extensions.gone
import com.cyxbs.components.utils.extensions.setImageFromUrl
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.bean.ProductDetail
import com.cyxbs.pages.store.page.exchange.viewmodel.ProductExchangeViewModel
import com.cyxbs.pages.store.utils.StoreType
import com.google.android.material.button.MaterialButton
import com.ndhzs.slideshow.SlideShow
import com.ndhzs.slideshow.adapter.ImageViewAdapter
import com.ndhzs.slideshow.adapter.setImgAdapter
import com.ndhzs.slideshow.viewpager.transformer.AlphaPageTransformer
import com.ndhzs.slideshow.viewpager.transformer.ScaleInTransformer

/**
 *    author : zz
 *    e-mail : 1140143252@qq.com
 *    date   : 2021/8/2 11:55
 */
class ProductExchangeActivity : BaseActivity() {
  
  private val mViewModel by viewModelBy { ProductExchangeViewModel(mShopId) }
  
  private lateinit var mData: ProductDetail // 记录该页面的商品数据, 用于之后的判断
  private val mShopId by intent<Int>() //商品ID
  private var mStampCount by intent<Int>() //我的余额
  private val mIsPurchased by intent<Boolean>() // 是否已经购买过, 只有邮货才有购买限制

  private val storeBtnExchange by R.id.store_btn_exchange.view<MaterialButton>()
  private val storeTvUserStampCount by R.id.store_tv_user_stamp_count.view<TextView>()
  private val storeTvExchangeDetailPrice by R.id.store_tv_exchange_detail_price.view<TextView>()
  private val storeTvProductName by R.id.store_tv_product_name.view<TextView>()
  private val storeTvProductDetailTitle by R.id.store_tv_product_detail_title.view<TextView>()
  private val storeTvEquityDescription by R.id.store_tv_equity_description.view<TextView>()
  private val storeSsExchangeProductImage by R.id.store_ss_exchange_product_image.view<SlideShow>()
  private val storeTvProductStock by R.id.store_tv_product_stock.view<TextView>()
  private val storeTvProductPrescription by R.id.store_tv_product_prescription.view<TextView>()

  companion object {
    fun activityStart(context: Context, id: Int, stampCount: Int, isPurchased: Boolean) {
      context.startActivity(
        Intent(context, ProductExchangeActivity::class.java)
          .putExtra(ProductExchangeActivity::mShopId.name, id)
          .putExtra(ProductExchangeActivity::mStampCount.name, stampCount)
          .putExtra(ProductExchangeActivity::mIsPurchased.name, isPurchased)
      )
    }
  }
  
  override fun onCreate(savedInstanceState: Bundle?) {
    // 降低因使用共享动画进入 activity 后的白闪情况
    window.setBackgroundDrawableResource(android.R.color.transparent)
    super.onCreate(savedInstanceState)
    setContentView(R.layout.store_activity_product_exchange)
    initView()
    initJump()
    initObserve()
  }
  
  private fun initView() {
    if (mIsPurchased) { // 如果已经购买过
      storeBtnExchange.setBackgroundColor(R.color.store_btn_ban_product_exchange.color)
    }
    storeTvUserStampCount.text = mStampCount.toString()
    storeBtnExchange.isCheckable = true // 防止因为 Activity 重建而导致没有恢复
  }
  
  private fun initJump() {
    //设置左上角返回点击事件
    val button: ImageButton = findViewById(R.id.store_iv_toolbar_arrow_left)
    button.setOnSingleClickListener { finishAfterTransition() }
    
    storeBtnExchange.setOnSingleClickListener {
      if (mIsPurchased) { // 如果已经购买过就禁止显示 dialog
        toast("每种商品只限领一次哦")
        return@setOnSingleClickListener
      }
      it.isClickable = false // 在继续显示 dialog 期间禁止用户点击
      ChooseDialog.Builder(
        this,
        ChooseDialog.DataImpl(
          content = "确认要用${storeTvExchangeDetailPrice.text}" +
            "邮票兑换${storeTvProductName.text}吗？",
          width = 300,
          height = 178,
        )
      ).setPositiveClick {
        mViewModel.getExchangeResult(mShopId) // 请求用户是否能购买
        dismiss()
      }.setNegativeClick {
        dismiss()
        it.isClickable = true
      }.setCancelCallback {
        it.isClickable = true
      }.show()
    }
  }
  
  @SuppressLint("SetTextI18n")
  private fun initObserve() {
    mViewModel.productDetail.observe {
      bindData(it)
      // 处理权益说明以及标题
      when (it.type) {
        StoreType.Product.DRESS -> {
          storeTvProductDetailTitle.text =
            getString(R.string.store_attire_product_detail)
          storeTvEquityDescription.text =
            "1、虚拟商品版权归红岩网校工作站所有。\n" +
              "2、在法律允许的范围内，本活动的最终解释权归红岩网校工作站所有。"
        }
        StoreType.Product.GOODS -> {
          storeTvProductDetailTitle.text =
            getString(R.string.store_entity_product_detail)
          storeTvEquityDescription.text =
            "1、每个实物商品每人限兑换一次，已经兑换的商品不能退货换货也不予折现。\n" +
              "2、在法律允许的范围内，本活动的最终解释权归红岩网校工作站所有。"
        }
      }
      //初始化轮播图
      initSlideShow(it.urls)
      //保存
      mData = it
    }
  
    // 请求购买成功的观察（状态）
    mViewModel.exchangeResultState.observe {
      // 根据不同商品类型弹出不同dialog
      when (mData.type) {
        StoreType.Product.DRESS -> {
          mData.amount = it.amount //由兑换成功时获取到的最新amount来更新mData 下同
          bindData(mData) //重新绑定是实现 购买后库存为0时 兑换按钮置灰(是否置灰的逻辑绑定在xml里) 下同
          storeTvUserStampCount.text = mStampCount.toString()
        }
        StoreType.Product.GOODS -> {
          mData.amount = it.amount
          bindData(mData)
          storeTvUserStampCount.text = mStampCount.toString()
        }
      }
    }
  
    // 请求购买成功的观察（事件）
    mViewModel.exchangeResultEvent.collectLaunch {
      // 根据不同商品类型弹出不同dialog
      when (mData.type) {
        StoreType.Product.DRESS -> {
          mStampCount -= mData.price
          ChooseDialog.Builder(
            this,
            ChooseDialog.DataImpl(
              content = "兑换成功！现在就换掉原来的名片吧！",
              width = 300,
              height = 178,
              positiveButtonText = "好的",
              negativeButtonText = "再想想"
            )
          ).setPositiveClick {
            toast("个人界面即将上线")
            /*
            * 这里按下"好的", 应该还要写一个跳转
            *
            * 应该是跳转到个人界面
            *
            * TODO 23年：个人中心已下架，这里暂时搁置
            * */
            dismiss()
          }.setNegativeClick {
            dismiss()
          }.setDismissCallback {
            storeBtnExchange.isClickable = true
          }.show()
        }
        StoreType.Product.GOODS -> {
          mStampCount -= mData.price
          ChooseDialog.Builder(
            this,
            ChooseDialog.DataImpl(
              content = "兑换成功！请在30天内到红岩网校领取哦",
              width = 300,
              height = 178,
              type = BaseChooseDialog.DialogType.ONE_BUT
            )
          ).setPositiveClick {
            dismiss()
          }.setDismissCallback {
            storeBtnExchange.isClickable = true
          }.show()
        }
      }
    }
    
    // 请求失败的观察（事件）
    mViewModel.exchangeErrorEvent.collectLaunch {
      when (it) {
        StoreType.ExchangeError.OUT_OF_STOCK -> {
          ChooseDialog.Builder(
            this,
            ChooseDialog.DataImpl(
              content = "啊欧，手慢了！下次再来吧=.=",
              width = 300,
              height = 178,
              type = BaseChooseDialog.DialogType.ONE_BUT
            )
          ).setPositiveClick {
            dismiss()
          }.setDismissCallback {
            storeBtnExchange.isClickable = true
          }.show()
        }
        StoreType.ExchangeError.NOT_ENOUGH_MONEY -> {
          ChooseDialog.Builder(
            this,
            ChooseDialog.DataImpl(
              content = "诶......邮票不够啊......穷日子真不好过呀QAQ",
              width = 300,
              height = 178,
              type = BaseChooseDialog.DialogType.ONE_BUT
            )
          ).setPositiveClick {
            dismiss()
          }.setDismissCallback {
            storeBtnExchange.isClickable = true
          }.show()
        }
        StoreType.ExchangeError.IS_PURCHASED -> {
          /*
          * 这里是不会触发的, 因为在之前就判断过是否已经购买而取消了 dialog
          * */
          toast("每种商品只限领一次哦")
          storeBtnExchange.isClickable = true
        }
        else -> {
          toast("兑换请求异常")
          storeBtnExchange.isClickable = true
        }
      }
    }
  }

  @SuppressLint("SetTextI18n")
  private fun bindData(data: ProductDetail) {
    storeTvProductName.text = data.title
    storeTvProductStock.text = "库存量：${data.amount}"
    storeTvEquityDescription.text = data.description
    if (data.life == 0) {
      storeTvProductPrescription.gone()
    } else {
      storeTvProductPrescription.text = "有效期: ${data.life}天"
    }
    storeTvExchangeDetailPrice.text = "${data.price}"
    storeBtnExchange.isClickable = data.amount > 0
    storeBtnExchange.setBackgroundColor(
      if (data.amount > 0) R.color.store_btn_product_exchange.color
      else R.color.store_btn_ban_product_exchange.color
    )
  }
  
  private var mPositionResult: PhotoViewerActivity.Companion.Position? = null
  
  private fun initSlideShow(imgUrls: List<String>) {
    storeSsExchangeProductImage
      .addTransformer(ScaleInTransformer())
      .addTransformer(AlphaPageTransformer())
      .setIsCyclical(true)
      .setImgAdapter(
        ImageViewAdapter.Builder(imgUrls)
          .onCreate {
            view.setOnSingleClickListener {
              // 装扮详情点击图片的元素共享动画
              val options = ActivityOptionsCompat.makeSceneTransitionAnimation(
                this@ProductExchangeActivity, Pair(
                  storeSsExchangeProductImage,
                  "productImage"
                )
              )
              
              mPositionResult = PhotoViewerActivity.start(
                this@ProductExchangeActivity, ArrayList(imgUrls),
                // 因为开启了循环滑动, 所以必须使用 realPosition 得到你所看到的位置
                realPosition, options.toBundle()
              )
            }
          }.onBind {
            view.setImageFromUrl(data)
          }
      )
  }
  
  override fun onRestart() {
    super.onRestart()
    val position = mPositionResult
    if (position != null) {
      mPositionResult = null
      // 从 PhotoActivity 返回时就使轮播图跳转到对应位置
      storeSsExchangeProductImage
        .setCurrentItem(position.value, false)
    }
  }
}