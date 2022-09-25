package com.mredrock.cyxbs.affair.ui.viewmodel.fragment

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.affair.net.AffairApiService
import com.mredrock.cyxbs.affair.net.AffairRepository
import com.mredrock.cyxbs.affair.room.AffairEntity
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.network.mapOrThrowApiException
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/6/10 10:31
 */
class AddAffairViewModel : BaseViewModel() {

  private val _titleCandidates = MutableLiveData<List<String>>()
  val titleCandidates: LiveData<List<String>>
    get() = _titleCandidates

  fun addAffair(
    time: Int,
    title: String,
    content: String,
    atWhatTime: List<AffairEntity.AtWhatTime>,
  ) {
    AffairRepository.addAffair(time, title, content, atWhatTime)
  }

  init {
    AffairApiService.INSTANCE.getTitleCandidate()
      .subscribeOn(Schedulers.io())
      .observeOn(AndroidSchedulers.mainThread())
      .mapOrThrowApiException()
      .safeSubscribeBy {
        _titleCandidates.value = it
      }
  }
//
//  private fun addRemind(
//    title: String,
//    description: String,
//    startRow: Int,
//    period: Int,
//    week: Int,
//    remindMinutes: Int,
//  ) {
//    CalendarUtils.addCalendarEventRemind(
//      requireActivity(),
//      title,
//      description,
//      TimeUtils.getBegin(startRow, week),
//      TimeUtils.getDuration(period),
//      TimeUtils.getRRule(week),
//      remindMinutes,
//      object : CalendarUtils.OnCalendarRemindListener {
//        override fun onFailed(error_code: CalendarUtils.OnCalendarRemindListener.Status?) {
//          "添加失败".toast()
//        }
//
//        override fun onSuccess() {
//          "添加成功".toast()
//        }
//      })
//  }
}