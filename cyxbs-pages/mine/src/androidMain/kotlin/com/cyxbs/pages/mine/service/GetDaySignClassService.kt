package com.cyxbs.pages.mine.service

import android.app.Activity
import android.content.Context
import com.alibaba.android.arouter.facade.annotation.Route
import com.cyxbs.pages.mine.api.IGetDaySignClassService
import com.cyxbs.pages.mine.api.MINE_SERVICE
import com.cyxbs.pages.mine.page.sign.DailySignActivity

@Route(path = MINE_SERVICE, name = MINE_SERVICE)
class GetDaySignClassService : IGetDaySignClassService {
    private var mContext: Context? = null

    override fun getDaySignClassService(): Class<out Activity> {
        return DailySignActivity::class.java
    }

    override fun init(context: Context?) {
        mContext = context
    }
}