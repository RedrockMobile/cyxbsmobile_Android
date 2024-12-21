package com.cyxbs.pages.mine.api

import android.app.Activity
import com.alibaba.android.arouter.facade.template.IProvider

interface IGetDaySignClassService : IProvider {

    fun getDaySignClassService(): Class<out Activity>

}