package com.cyxbs.pages.volunteer.service

import androidx.fragment.app.Fragment
import com.cyxbs.pages.volunteer.api.IVolunteerService
import com.cyxbs.pages.volunteer.fragment.DiscoverVolunteerFeedFragment
import com.g985892345.provider.api.annotation.ImplProvider

/**
 * Created by yyfbe, Date on 2020/8/31.
 */
@ImplProvider
object VolunteerService : IVolunteerService {
    override fun getVolunteerFeed(): Fragment {
        return DiscoverVolunteerFeedFragment()
    }
}