/**
 * @Author fxy
 * @Date 2019-12-10 20:44
 */

package com.mredrock.cyxbs.discover.grades.ui.viewModel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.mredrock.cyxbs.common.network.ApiGenerator
import com.mredrock.cyxbs.common.utils.extensions.*
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import com.mredrock.cyxbs.discover.grades.R
import com.mredrock.cyxbs.discover.grades.bean.Exam
import com.mredrock.cyxbs.discover.grades.bean.Status
import com.mredrock.cyxbs.discover.grades.bean.analyze.GPAStatus
import com.mredrock.cyxbs.discover.grades.network.ApiService
import com.mredrock.cyxbs.lib.utils.extensions.unsafeSubscribeBy
import io.reactivex.rxjava3.core.Observable

class ContainerViewModel : BaseViewModel() {

    //当前采取的考试展示策略
    val nowStatus = MutableLiveData<Status>()

    val examData = MutableLiveData<List<Exam>>()
    private val apiService = ApiGenerator.getApiService(ApiService::class.java)
    fun loadData(stuNum: String) {
        val exam = apiService.getExam(stuNum)
        val reExam = apiService.getReExam(stuNum)

        Observable.merge(exam, reExam)
            .setSchedulers()
            .mapOrThrowApiException()
            .doOnErrorWithDefaultErrorHandler {
                toastEvent.value = R.string.grades_no_exam_history
                false
            }
            .unsafeSubscribeBy {
                examData.value = it
            }.lifeCycle()

    }

    private val _analyzeData = MutableLiveData<GPAStatus>()
    val analyzeData: LiveData<GPAStatus>
        get() = _analyzeData

    fun getAnalyzeData() {
        apiService.getAnalyzeData()
            .setSchedulers()
            .doOnError {
                toast("加载绩点失败")
            }
            .unsafeSubscribeBy {
                _analyzeData.postValue(it)
            }.lifeCycle()
    }

    //获取当前采取的成绩展示方案
    fun getStatus() {
        apiService.getNowStatus()
            .setSchedulers()
            .unsafeSubscribeBy {
                it.data.let { status ->
                    nowStatus.postValue(status)
                }
            }
    }

}