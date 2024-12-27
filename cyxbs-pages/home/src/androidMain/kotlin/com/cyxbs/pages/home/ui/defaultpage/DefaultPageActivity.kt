package com.cyxbs.pages.home.ui.defaultpage

import android.os.Bundle
import android.widget.ImageButton
import com.alibaba.android.arouter.facade.annotation.Route
import com.cyxbs.components.config.route.DEFAULT_PAGE
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.visible
import com.cyxbs.pages.home.R

/**
 * @author : why
 * @time   : 2022/10/30 21:02
 * @bless  : God bless my code
 */
@Route(path = DEFAULT_PAGE)
class DefaultPageActivity: BaseActivity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.home_activity_default_page)
        val iv = findViewById<ImageButton>(R.id.home_default_page_back)
        iv.visible()
        iv.setOnClickListener { finishAndRemoveTask() }
    }
}