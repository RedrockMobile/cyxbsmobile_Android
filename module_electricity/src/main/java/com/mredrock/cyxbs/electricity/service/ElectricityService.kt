package com.mredrock.cyxbs.electricity.service

import android.content.Context
import androidx.fragment.app.Fragment
import com.alibaba.android.arouter.facade.annotation.Route
import com.alibaba.android.arouter.launcher.ARouter
import com.mredrock.cyxbs.api.electricity.ELECTRICITY_SERVICE
import com.mredrock.cyxbs.api.electricity.IElectricityService
import com.mredrock.cyxbs.config.route.DISCOVER_ELECTRICITY_FEED

/**
 * Created by yyfbe, Date on 2020/8/31.
 */
@Route(path = ELECTRICITY_SERVICE, name = ELECTRICITY_SERVICE)
class ElectricityService : IElectricityService {
    private var mContext: Context? = null
    override fun getElectricityFeed(): Fragment {
        return ARouter.getInstance().build(DISCOVER_ELECTRICITY_FEED).navigation() as Fragment
    }

    override fun init(context: Context?) {
        this.mContext = context
    }
}