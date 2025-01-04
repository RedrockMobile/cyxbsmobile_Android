package com.cyxbs.pages.mine.page.feedback.history.list

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.feedback.adapter.RvListAdapter
import com.cyxbs.pages.mine.page.feedback.history.detail.HistoryDetailActivity
import com.cyxbs.pages.mine.page.feedback.history.list.bean.History

class HistoryListActivity : BaseActivity() {

    private val viewModel by viewModels<HistoryListViewModel>()

    /**
     * rv_history_list
     * 初始化两个adapter
     */
    private val rvAdapter by lazy {
        RvListAdapter()
    }

    private val rvHistoryList by R.id.rv_history_list.view<RecyclerView>()
    private val tvTitle by R.id.tv_title.view<TextView>()
    private val btnBack by R.id.btn_back.view<View>()
    private val tvNoneHistory by R.id.tv_none_history.view<View>()
    private val ivNoneHistory by R.id.mine_appcompatimageview.view<View>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mine_activity_history_list)
        initView()
        initListener()
        observeData()
    }

    /**
     * 初始化视图
     */
    private fun initView() {
        //初始化Rv配置
        rvHistoryList.apply {
            adapter = rvAdapter
            layoutManager = LinearLayoutManager(this@HistoryListActivity)
        }

        tvTitle.text = resources.getText(R.string.mine_feedback_toolbar_text)

    }

    /**
     * 初始化listener
     */
    private fun initListener() {
        //RecyclerView的Item点击
        rvAdapter.setOnItemClickListener(
            object : RvListAdapter.ItemClickListener {
                override fun clicked(data: History) {
                    viewModel.savedState(data)
                    val intentExtra = Intent(this@HistoryListActivity,
                        HistoryDetailActivity::class.java).putExtra("historyId", data.id)
                    startActivity(intentExtra)
                }
            }
        )

        //返回键的点击监听
        btnBack.setOnSingleClickListener {
            finish()
        }
    }

    /**
     * 观察vm数据变化
     */
    private fun observeData() {
        viewModel.listData.observe {
            rvAdapter.submitList(it)
            val hasHistory = it.isNotEmpty()
            rvHistoryList.visibility = if (hasHistory) View.VISIBLE else View.GONE
            tvNoneHistory.visibility = if (hasHistory) View.GONE else View.VISIBLE
            ivNoneHistory.visibility = if (hasHistory) View.GONE else View.VISIBLE
        }
    }
}