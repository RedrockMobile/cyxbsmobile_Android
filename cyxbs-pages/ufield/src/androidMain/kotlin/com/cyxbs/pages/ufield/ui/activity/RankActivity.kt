package com.cyxbs.pages.ufield.ui.activity

import android.os.Bundle
import android.widget.RelativeLayout
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.ufield.R
import com.cyxbs.pages.ufield.adapter.RankAdapter
import com.cyxbs.pages.ufield.viewmodel.RankViewModel

class RankActivity : BaseActivity() {
    private val mViewModel by viewModels<RankViewModel>()

    /*
    * 返回按键
    * */
    private val mRankBack: RelativeLayout by R.id.ufield_activity_rank_rl_back.view()

    /*
    * 排行界面的RV
    * */
    private lateinit var mRankRvAdapter: RankAdapter
    private val mRankRV: RecyclerView by R.id.ufield_activity_rv.view()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.ufield_activity_rank)
        initViewClickListener()
        initObserve()
        initRV()
    }

    private fun initRV() {
        mRankRvAdapter= RankAdapter()
        mViewModel.rank.observe {
            mRankRvAdapter.submitList(it)
        }
        mRankRV.adapter = mRankRvAdapter
        mRankRV.layoutManager = LinearLayoutManager(this)
    }

    private fun initObserve() {
        mViewModel.getRank("all", 20, "watch")
    }

    private fun initViewClickListener() {
        mRankBack.setOnSingleClickListener { finish() }
    }
}