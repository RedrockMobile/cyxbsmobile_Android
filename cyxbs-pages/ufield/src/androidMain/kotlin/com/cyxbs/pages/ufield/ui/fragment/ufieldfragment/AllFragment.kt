package com.cyxbs.pages.ufield.ui.fragment.ufieldfragment

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseFragment
import com.cyxbs.pages.ufield.R
import com.cyxbs.pages.ufield.adapter.UfieldRvAdapter
import com.cyxbs.pages.ufield.bean.ItemActivityBean
import com.cyxbs.pages.ufield.helper.GridSpacingItemDecoration
import com.cyxbs.pages.ufield.ui.activity.DetailActivity
import com.cyxbs.pages.ufield.viewmodel.UFieldViewModel
import com.scwang.smart.refresh.header.ClassicsHeader
import com.scwang.smart.refresh.layout.SmartRefreshLayout


class AllFragment : BaseFragment() {

    private val mRv: RecyclerView by R.id.uField_all_rv.view()
    private val mViewModel by lazy {
        ViewModelProvider(requireActivity())[UFieldViewModel::class.java]
    }
    private val mAdapter: UfieldRvAdapter by lazy { UfieldRvAdapter() }

    private lateinit var mDataList: MutableList<ItemActivityBean.ItemAll>

    private val mRefresh: SmartRefreshLayout by R.id.uField_all_refresh.view()

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.ufield_fragment_all, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        iniRv()
        iniRefresh()
    }

    /**
     * 初始化展示Rv
     */
    private fun iniRv() {

        mViewModel.apply {
            allList.observe {
                mDataList = it as MutableList<ItemActivityBean.ItemAll>
                mAdapter.submitList(it)
            }
        }
        mRv.apply {
            layoutManager = GridLayoutManager(requireContext(), 2)
            adapter = mAdapter.apply {
                setOnActivityClick {
                    val intent = Intent(requireContext(), DetailActivity::class.java)
                    intent.putExtra("actID", mDataList[it].activityId)
                    startActivity(intent)
                }

            }
            addItemDecoration(GridSpacingItemDecoration(2))

        }

    }

    /**
     * 处理下拉刷新
     */
    private fun iniRefresh() {
        mRefresh.apply {
            setRefreshHeader(ClassicsHeader(requireContext()))
            setEnableLoadMore(false)
            //下拉刷新
            setOnRefreshListener {
                mViewModel.apply {
                    getAllActivityList()
                }
                finishRefresh(500)
            }
        }

    }
}