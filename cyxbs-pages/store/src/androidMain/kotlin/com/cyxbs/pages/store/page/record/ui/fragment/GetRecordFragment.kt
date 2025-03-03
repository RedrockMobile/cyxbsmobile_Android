package com.cyxbs.pages.store.page.record.ui.fragment

import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseFragment
import com.cyxbs.components.utils.extensions.dp2px
import com.cyxbs.pages.store.R
import com.cyxbs.pages.store.utils.SimpleRvAdapter
import com.cyxbs.pages.store.bean.StampGetRecord
import com.cyxbs.pages.store.page.record.ui.item.GetPageItem
import com.cyxbs.pages.store.page.record.ui.item.ProgressBarItem
import com.cyxbs.pages.store.page.record.viewmodel.RecordViewModel

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2021/9/4
 * @time 12:46
 */
class GetRecordFragment : BaseFragment(R.layout.store_fragment_record_get) {
    // 因为我只需要 Activity 的 ViewModel, 所以没有继承于 BaseViewModelFragment
    private val viewModel by activityViewModels<RecordViewModel>()

    private lateinit var mRecyclerView: RecyclerView
    private lateinit var mImageView: ImageView
    private lateinit var mTextView: TextView

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        initView(view)
        initObserve()
    }

    private fun initView(view: View) {
        mRecyclerView = view.findViewById(R.id.store_rv_fragment_record_get)
        mImageView = view.findViewById(R.id.store_iv_fragment_record_get)
        mTextView = view.findViewById(R.id.store_tv_fragment_record_get)
    }

    private fun initObserve() {
        viewModel.firstPageGetRecordIsSuccessfulState.observe {
            if (!it) {
                showNoInterceptImage()
            }
        }
        viewModel.pageStampGetRecord.observe {
            if (it.isEmpty()) {
                mImageView.setImageResource(R.drawable.store_ic_fragment_record_get_null)
                mTextView.text = "还没有获取记录，快去做任务吧"
            } else {
                setPageGetAdapter(it)
            }
        }
        viewModel.nestPageGetRecordIsSuccessfulState.observe {
            mProgressBarItem.hideProgressBarWhenNoMoreData() // 取消 ProgressBar 动画
        }
        viewModel.nestPageGetRecordIsSuccessfulEvent.collectLaunch {
            if (!it) {
                toast("获取更多记录失败")
            }
        }
    }

    private fun showNoInterceptImage() {
        mImageView.setImageResource(R.drawable.store_ic_no_internet)
        val lp = mImageView.layoutParams
        lp.width = 157.dp2px // 那张没有网络的图片有点小
        lp.height = 96.dp2px
        mImageView.layoutParams = lp
        mTextView.text = getText(R.string.store_no_internet)
    }

    private lateinit var mGetPageItem: GetPageItem
    private lateinit var mProgressBarItem: ProgressBarItem
    private fun setPageGetAdapter(list: List<StampGetRecord>) {
        // 若 adapter 未设置 则进行设置
        if (mRecyclerView.adapter == null) {
            mGetPageItem = GetPageItem(list, 0)
            mProgressBarItem = ProgressBarItem(list.size)

            mRecyclerView.layoutManager = LinearLayoutManager(context)
            mRecyclerView.adapter = SimpleRvAdapter()
                .addItem(mGetPageItem)
                .addItem(mProgressBarItem)
                .show()

            mRecyclerView.addOnScrollListener(object : LoadMoreOnScrollListener() {
                override fun onLoadMore() {
                    viewModel.getNextPageGetRecord() // 请求之后的数据
                }
            })
        }else {
            mGetPageItem.refresh(list, 0)
            mProgressBarItem.refresh(list.size)
        }
    }

    /**
     * RecyclerView 的滑动监听, 用于设置分页加载
     */
    private abstract class LoadMoreOnScrollListener : RecyclerView.OnScrollListener() {

        private var totalItemCount = 0 // 已经加载出来的item个数
        private var isLoading = false
        private lateinit var mLinearLayoutManager: LinearLayoutManager

        override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
            super.onScrolled(recyclerView, dx, dy)
            if (!this::mLinearLayoutManager.isInitialized) {
                val layoutManager = recyclerView.layoutManager
                if (layoutManager is LinearLayoutManager) {
                    mLinearLayoutManager = layoutManager
                } else {
                    error("layoutManager 不是 LinearLayoutManager")
                }
            }
            if (isLoading && totalItemCount != mLinearLayoutManager.itemCount) {
                isLoading = false
            }
            if (!isLoading) {
                totalItemCount = mLinearLayoutManager.itemCount // item总数
                // 如果屏幕底显示的 item 位置是倒数第二个 item 时
                if (mLinearLayoutManager.findLastVisibleItemPosition() == totalItemCount - 2) {
                    isLoading = true
                    onLoadMore()
                }
            }
        }

        abstract fun onLoadMore()
    }
}