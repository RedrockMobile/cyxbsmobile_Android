package com.cyxbs.pages.affair.ui.viewmodel.fragment

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.affair.bean.Todo
import com.cyxbs.pages.affair.bean.TodoListPushWrapper
import com.cyxbs.pages.affair.model.AffairRepository
import com.cyxbs.pages.affair.net.AffairApiService
import com.cyxbs.pages.affair.room.AffairEntity
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.getSp
import com.cyxbs.components.utils.network.mapOrInterceptException
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
            .safeSubscribeBy {
                "添加成功".toast()
            }
    }

    fun addTodo(todo: Todo) {
        val pushWrapper = TodoListPushWrapper(
            listOf(todo),
            getLastSyncTime()
        )
        AffairRepository.addTodo(pushWrapper)
            .mapOrInterceptException {  }
            .doOnError{}
            .safeSubscribeBy {
               setLastSyncTime(it.syncTime)
            }
    }

    /**
     * 得到和设置本地最后同步的时间戳
     */
    private fun getLastSyncTime(): Long =
        appContext.getSp("todo").getLong("TODO_LAST_SYNC_TIME", 0L)

    private fun setLastSyncTime(syncTime: Long) {
        appContext.getSp("todo").edit().apply {
            putLong("TODO_LAST_SYNC_TIME", syncTime)
            commit()
        }
    }

    init {
        AffairApiService.INSTANCE.getTitleCandidate()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                // 网络请求失败就发送这个默认显示
                emitter.onSuccess(
                    listOf(
                        "自习",
                        "值班",
                        "考试",
                        "英语",
                        "开会",
                        "作业",
                        "补课",
                        "实验",
                        "复习",
                        "学习"
                    )
                )
            }.safeSubscribeBy {
                _titleCandidates.value = it
            }
    }
}