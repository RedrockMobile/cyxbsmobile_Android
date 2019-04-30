package com.mredrock.cyxbs.discover.news.ui.activity

import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import com.alibaba.android.arouter.facade.annotation.Route
import com.mredrock.cyxbs.common.config.DISCOVER_NEWS
import com.mredrock.cyxbs.common.ui.BaseViewModelActivity
import com.mredrock.cyxbs.discover.news.R
import com.mredrock.cyxbs.discover.news.ui.adapter.NewsAdapter
import com.mredrock.cyxbs.discover.news.viewmodel.NewsListViewModel
import kotlinx.android.synthetic.main.news_activity_list.*
import org.jetbrains.anko.startActivity

@Route(path = DISCOVER_NEWS)
class NewsListActivity : BaseViewModelActivity<NewsListViewModel>() {
    override val viewModelClass: Class<NewsListViewModel> = NewsListViewModel::class.java
    override val isFragmentActivity = false

    private lateinit var adapter: NewsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.news_activity_list)

        common_toolbar.init("教务新闻")

        viewModel.newsEvent.observe {
            srl_list.isRefreshing = false
            adapter.appendNewsList(it ?: return@observe)
        }

        srl_list.setOnRefreshListener {
            adapter.clear()
            viewModel.clearPages()
            viewModel.loadNewsData()
        }

        adapter = NewsAdapter(viewModel::loadNewsData)
        rv_list.layoutManager = LinearLayoutManager(this)
        rv_list.adapter = adapter

    }

}
