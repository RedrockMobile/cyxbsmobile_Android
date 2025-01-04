package com.cyxbs.pages.mine.page.security.activity

import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentTransaction
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.components.utils.extensions.setOnSingleClickListener
import com.cyxbs.pages.mine.R
import com.cyxbs.pages.mine.page.security.fragment.LoginIdsFragment

class FindPasswordByIdsActivity : BaseActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mine_activity_find_password_ids)
        replaceFragment(R.id.mine_fcv_find_password_ids_container) { LoginIdsFragment() }
        findViewById<View>(R.id.mine_btn_find_password_ids_top_back).setOnSingleClickListener {
            finish()
        }
    }

    fun replace(func: FragmentTransaction.() -> Fragment) {
        replaceFragment(R.id.mine_fcv_find_password_ids_container, func)
    }
}