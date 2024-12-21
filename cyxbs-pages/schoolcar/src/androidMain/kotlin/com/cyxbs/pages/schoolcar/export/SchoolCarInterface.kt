package com.cyxbs.pages.schoolcar.export

import com.cyxbs.pages.schoolcar.bean.SchoolCarLocation
import com.mredrock.cyxbs.lib.utils.network.ApiWrapper

/**
 * Created by glossimar on 2018/9/12
 */

interface SchoolCarInterface{
    fun processLocationInfo(carLocationInfo: ApiWrapper<SchoolCarLocation>, aLong: Long)
}