package com.mredrock.cyxbs.discover.grades.ui.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.mredrock.cyxbs.discover.grades.R


/**
 * Created by roger on 2020/3/20
 */
class NoDataFragment : Fragment() {

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.grades_fragment_no_data, container, false)
    }
}