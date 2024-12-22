package com.cyxbs.pages.course.page.find.viewmodel.fragment

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.cyxbs.pages.course.page.find.bean.FindStuBean
import com.cyxbs.pages.course.page.find.network.FindApiServices
import com.cyxbs.pages.course.page.find.room.FindStuEntity
import com.cyxbs.pages.course.page.find.room.HistoryDataBase
import com.cyxbs.pages.course.page.link.model.LinkRepository
import com.cyxbs.pages.course.page.link.room.LinkStuEntity
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.extensions.asFlow
import com.mredrock.cyxbs.lib.utils.network.api
import com.mredrock.cyxbs.lib.utils.network.mapOrThrowApiException
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import retrofit2.HttpException

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/2/8 17:54
 */
class FindStuViewModel : BaseViewModel() {
  
  private val _studentSearchData = MutableSharedFlow<List<FindStuBean>>()
  val studentSearchData: SharedFlow<List<FindStuBean>>
    get() = _studentSearchData
  
  private val _studentHistory = MutableLiveData<List<FindStuEntity>>()
  val studentHistory: LiveData<List<FindStuEntity>>
    get() = _studentHistory
  
  private val _linkStudent = MutableLiveData<LinkStuEntity?>(null)
  val linkStudent: LiveData<LinkStuEntity?>
    get() = _linkStudent
  
  fun searchStudents(stu: String) {
    FindApiServices::class.api
      .getStudents(stu)
      .subscribeOn(Schedulers.io())
      .asFlow()
      .mapOrThrowApiException()
      //数据请求有多次请求受限，这里检测出okhttp拦截下的异常为HttpException，异常码为429，所以这里对其进行处理
      .catch { throwable ->
        val code = (throwable as? HttpException)?.code()
        if (code == 429) toast("查询过于频繁，请稍后再试") else toast("网络似乎开小差了")
      }
      .collectLaunch {
        _studentSearchData.emit(it)
      }
  }
  
  fun deleteHistory(num: String) {
    viewModelScope.launch(Dispatchers.IO) {
      HistoryDataBase.INSTANCE.getStuDao()
        .deleteStuFromNum(num)
    }
  }
  
  fun changeLinkStudent(stuNum: String) {
    LinkRepository.changeLinkStudent(stuNum)
      .observeOn(AndroidSchedulers.mainThread())
      .safeSubscribeBy()
  }
  
  init {
    // 数据库返回的 Observable，属于响应式查询，任何更改都会重新发出更新的通知
    HistoryDataBase.INSTANCE.getStuDao()
      .observeAllStu()
      .subscribeOn(Schedulers.io())
      .observeOn(AndroidSchedulers.mainThread())
      .distinctUntilChanged()
      .safeSubscribeBy {
        _studentHistory.value = it
      }
    
    LinkRepository.observeLinkStudent()
      .observeOn(AndroidSchedulers.mainThread())
      .safeSubscribeBy {
        if (it.isNotNull()) {
          _linkStudent.value = it
        } else {
          _linkStudent.value = null
        }
      }
  }
}