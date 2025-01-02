package com.cyxbs.pages.declare.main.page.activity

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.pages.declare.R
import com.cyxbs.pages.declare.detail.page.activity.DetailActivity
import com.cyxbs.pages.declare.main.page.adapter.HomeRvAdapter
import com.cyxbs.pages.declare.main.page.viewmodel.PostedViewModel
import com.cyxbs.pages.declare.post.PostActivity
import com.cyxbs.components.utils.extensions.gone
import com.cyxbs.components.utils.extensions.setOnDoubleClickListener
import com.cyxbs.components.utils.extensions.visible

/**
 * 因为发布过投票的页面和主页面差不多，所以这里就共用了主页面的xml
 */
class PostedActivity : BaseActivity() {
    /**
     * 启动表态详情页面
     */
    companion object {
        fun startActivity(context: Context) {
            context.startActivity(Intent(context, PostedActivity::class.java))
        }
    }

    private val mViewModel by viewModels<PostedViewModel>()

    private val declareHomeToolbarPost by R.id.declare_home_toolbar_post.view<View>()
    private val declareHomeRecyclerview by R.id.declare_home_recyclerview.view<RecyclerView>()
    private val declareHomeToolbarTv by R.id.declare_home_toolbar_tv.view<TextView>()
    private val declareHomeNoDataPic by R.id.declare_home_no_data_pic.view<ImageView>()
    private val declareHomeNoDataTv by R.id.declare_home_no_data_tv.view<TextView>()
    private val declareIvToolbarArrowLeft by R.id.declare_iv_toolbar_arrow_left.view<View>()
    private val declareHomeNoData by R.id.declare_home_no_data.view<View>()
    private val declareHomeCl by R.id.declare_home_cl.view<View>()
    private val declareHomeNoNet by R.id.declare_home_no_net.view<View>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.declare_activity_home)
        val declareHomeRvAdapter = HomeRvAdapter()
        declareHomeToolbarPost.visible()
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
        declareHomeRvAdapter.setOnItemClickedListener {
            DetailActivity.startActivity(this, it)
        }
        declareHomeToolbarPost.setOnClickListener {
            //跳至自己发布话题页面
            PostActivity.start(this)
        }
        declareIvToolbarArrowLeft.setOnClickListener {
            finish()
        }
        mViewModel.postedLiveData.observe {
            if (it.isEmpty()) {
                declareHomeNoData.visible()
            } else {
                declareHomeNoData.gone()
                declareHomeRvAdapter.submitList(it)
            }
        }
        mViewModel.postedErrorLiveData.observe {
            if (it) {
                declareHomeCl.gone()
                declareHomeNoNet.visible()
            } else {
                declareHomeCl.visible()
                declareHomeNoNet.gone()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        mViewModel.getPostedVotes()
    }
}