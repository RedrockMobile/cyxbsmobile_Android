package com.cyxbs.pages.declare.post

import com.cyxbs.pages.declare.post.net.PostApiService
import com.cyxbs.components.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.asFlow
import com.cyxbs.components.utils.network.ApiStatus
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

/**
 * com.mredrock.cyxbs.declare.pages.post.PostViewModel.kt
 * CyxbsMobile_Android
 *
 * @author 寒雨
 * @since 2023/2/8 下午3:28
 */
class PostViewModel : BaseViewModel() {
    // livedata 是粘性事件，不适合在这里使用，所以直接使用 SharedFlow
    private val _postResultFlow: MutableSharedFlow<ApiStatus> = MutableSharedFlow()
    val postResultFlow: SharedFlow<ApiStatus>
        get() = _postResultFlow

    fun post(title: String, choices: List<String>) {
        PostApiService.postVote(title, choices)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .asFlow()
            .collectLaunch {
                _postResultFlow.emit(it)
            }
    }
}