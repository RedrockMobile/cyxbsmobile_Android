package com.cyxbs.pages.schoolcar

import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.cyxbs.components.base.ui.BaseActivity
import com.cyxbs.pages.schoolcar.adapter.CarPageAdapter

/**
 *@Author:SnowOwlet
 *@Date:2022/5/7 12:00
 *
 */
class SchoolDetailActivity: BaseActivity(){

  private val vm by viewModels<SchoolDetailViewModel>()

  private val schoolCarDetailRv by R.id.school_car_detail_rv.view<RecyclerView>()
  private val schoolCarDetailIv by R.id.school_car_detail_iv.view<View>()

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.schoolcar_activity_detail_schoolcar)
    vm.mapInfo.observe(this){
      schoolCarDetailRv.apply {
        layoutManager = LinearLayoutManager(this@SchoolDetailActivity)
        this.adapter = CarPageAdapter(this@SchoolDetailActivity,it.lines)
      }
    }
    vm.initMapInfo()
    schoolCarDetailIv.setOnClickListener {
      finish()
    }
  }
}