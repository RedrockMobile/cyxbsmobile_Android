package com.cyxbs.pages.sport.service

import androidx.fragment.app.Fragment
import com.cyxbs.pages.sport.api.ISportService
import com.cyxbs.pages.sport.ui.fragment.DiscoverSportFeedFragment
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * @author : why
 * @time   : 2022/8/12 17:06
 * @bless  : God bless my code
 */
@ImplProvider
object SportService : ISportService {
    override fun getSportFeed(): Fragment = DiscoverSportFeedFragment()
}