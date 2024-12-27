/**
 * @Author fxy
 * @Date 2019-12-10 20:44
 */

package com.cyxbs.pages.grades.ui.viewModel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.grades.R
import com.cyxbs.pages.grades.bean.Exam
import com.cyxbs.pages.grades.bean.Status
import com.cyxbs.pages.grades.bean.analyze.GPAStatus
import com.cyxbs.pages.grades.bean.analyze.isSuccessful
import com.cyxbs.pages.grades.network.ApiService
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.setSchedulers
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.mapOrInterceptException
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
            .mapOrInterceptException {
                toast(R.string.grades_no_exam_history)
            }
            .safeSubscribeBy {
                examData.value = it
            }

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
            .safeSubscribeBy {
                if (it.isSuccessful) {
                    _analyzeData.postValue(it)
                }
            }
    }

    //获取当前采取的成绩展示方案
    fun getStatus() {
        apiService.getNowStatus()
            .setSchedulers()
            .safeSubscribeBy {
                it.data.let { status ->
                    nowStatus.postValue(status)
                }
            }
    }

}