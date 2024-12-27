package com.cyxbs.pages.declare.main.page.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import com.cyxbs.pages.declare.R
import com.cyxbs.pages.declare.databinding.DeclareActivityHomeBinding
import com.cyxbs.pages.declare.detail.page.activity.DetailActivity
import com.cyxbs.pages.declare.main.page.adapter.HomeRvAdapter
import com.cyxbs.pages.declare.main.page.viewmodel.PostedViewModel
import com.cyxbs.pages.declare.post.PostActivity
import com.cyxbs.components.base.ui.BaseBindActivity
import com.cyxbs.components.utils.extensions.gone
import com.cyxbs.components.utils.extensions.setOnDoubleClickListener
import com.cyxbs.components.utils.extensions.visible

/**
 * 因为发布过投票的页面和主页面差不多，所以这里就共用了主页面的xml
 */
class PostedActivity : BaseBindActivity<DeclareActivityHomeBinding>() {
    /**
     * 启动表态详情页面
     */
    companion object {
        fun startActivity(context: Context) {
            context.startActivity(Intent(context, PostedActivity::class.java))
        }
    }

    private val mViewModel by viewModels<PostedViewModel>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val declareHomeRvAdapter = HomeRvAdapter()
        binding.declareHomeToolbarPost.visible()
        binding.run {
            declareHomeRecyclerview.run {
                layoutManager = LinearLayoutManager(this@PostedActivity)
                adapter = declareHomeRvAdapter
                declareHomeToolbarTv.text = resources.getString(R.string.declare_posted_title)
                declareHomeToolbarTv.setOnDoubleClickListener {
                    smoothScrollToPosition(0)
                }
            }
            declareHomeNoDataPic.setImageResource(R.drawable.declare_ic_posted_no_data)
            declareHomeNoDataTv.text = resources.getString(R.string.declare_posted_no_data)
            declareHomeToolbarPost.setBackgroundResource(R.drawable.declare_ic_mine_post)
        }
        declareHomeRvAdapter.setOnItemClickedListener {
            DetailActivity.startActivity(this, it)
        }
        binding.declareHomeToolbarPost.setOnClickListener {
            //跳至自己发布话题页面
            PostActivity.start(this)
        }
        binding.declareIvToolbarArrowLeft.setOnClickListener {
            finish()
        }
        mViewModel.postedLiveData.observe {
            if (it.isEmpty()) {
                binding.declareHomeNoData.visible()
            } else {
                binding.declareHomeNoData.gone()
                declareHomeRvAdapter.submitList(it)
            }
        }
        mViewModel.postedErrorLiveData.observe {
            if (it) {
                binding.declareHomeCl.gone()
                binding.declareHomeNoNet.visible()
            } else {
                binding.declareHomeCl.visible()
                binding.declareHomeNoNet.gone()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        mViewModel.getPostedVotes()
    }
}