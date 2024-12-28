package com.cyxbs.pages.mine

import android.animation.ValueAnimator
import android.view.View
import android.view.animation.DecelerateInterpolator
import android.widget.TextView
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.viewModelScope
import com.cyxbs.components.config.sp.defaultSp
import com.cyxbs.components.utils.extensions.EmptyCoroutineExceptionHandler
import com.cyxbs.components.utils.extensions.setSchedulers
import com.cyxbs.components.utils.extensions.unsafeSubscribeBy
import com.cyxbs.components.utils.network.ApiWrapper
import com.cyxbs.pages.mine.network.model.ItineraryMsgBean
import com.cyxbs.pages.mine.network.model.ScoreStatus
import com.cyxbs.pages.mine.network.model.UfieldMsgBean
import com.cyxbs.pages.mine.network.model.UserCount
import com.cyxbs.pages.mine.network.model.UserUncheckCount
import com.cyxbs.pages.mine.util.apiService
import com.mredrock.cyxbs.common.utils.extensions.doOnErrorWithDefaultErrorHandler
import com.mredrock.cyxbs.common.utils.extensions.mapOrThrowApiException
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.launch


/**
 * Created by zia on 2018/8/26.
 */
class UserViewModel : BaseViewModel() {

    companion object {
        const val UNCHECK_PRAISE_KEY = "mine/uncheck_praise"
        const val UNCHECK_COMMENT_KEY = "mine/uncheck_comment"
    }

    private val _status = MutableLiveData<ScoreStatus>()//签到状态
    val status: LiveData<ScoreStatus>
        get() = _status

    private val _userCount = MutableLiveData<UserCount?>()
    val userCount: LiveData<UserCount?>
        get() = _userCount

    private val _userUncheckCount = MutableLiveData<UserUncheckCount?>()
    val userUncheckCount: LiveData<UserUncheckCount?>
        get() = _userUncheckCount

    /**
     * ”新“通知消息（状态为未读的）的数量
     */
    val newNotificationCount: LiveData<Int> get() = _newNotificationCount
    private val _newNotificationCount = MutableLiveData<Int>()



    init {
        getNewNotificationCount()
    }

    /**
     * 用携程异步获取未读的notification数量
     */
    fun getNewNotificationCount() {
        viewModelScope.launch(EmptyCoroutineExceptionHandler) {
            val uFieldActivityList = async(Dispatchers.IO) { apiService.getUFieldActivityList() }
            val itineraryList = listOf(
                async(Dispatchers.IO) { apiService.getSentItinerary() },
                async(Dispatchers.IO) { apiService.getReceivedItinerary() }
            )
            val newUFieldActivityCount = async(Dispatchers.Default) {
                getNewActivityCount(uFieldActivityList.await())
            }
            val newItineraryCount = async(Dispatchers.Default) {
                getNewItineraryCount(itineraryList.awaitAll())
            }
            _newNotificationCount.value = (newUFieldActivityCount.await() + newItineraryCount.await())
        }
    }

    /**
     * 获取“新”活动通知的数量
     * @param response
     */
    private fun getNewActivityCount(response: ApiWrapper<List<UfieldMsgBean>>) : Int{
        return if (response.isSuccess()) {
            val list = response.data.filter { !it.clicked }
            list.size
        } else
            0
    }

    /**
     * 获取“新”行程通知的数量
     * @param response
     */
    private fun getNewItineraryCount(response: List<ApiWrapper<List<ItineraryMsgBean>?>>): Int{
        val receivedCount: Int = if (response[1].isSuccess() && !response[1].data.isNullOrEmpty()) {
            val list = response[1].data!!.filter { !it.hasRead }
            list.size
        } else 0
        val sentCount: Int = if (response[0].isSuccess() && !response[0].data.isNullOrEmpty()) {
            val list = response[0].data!!.filter { !it.hasRead }
            list.size
        } else 0
        return receivedCount + sentCount
    }


    fun getScoreStatus() {
        apiService.getScoreStatus()
            .mapOrThrowApiException()
            .setSchedulers()
            .doOnErrorWithDefaultErrorHandler { true }
            .unsafeSubscribeBy(
                onNext = {
                    _status.postValue(it)
                }
            )
            .lifeCycle()
    }

    //获取用户三大数据的数量
    fun getUserCount() {
        apiService.getUserCount()
            .setSchedulers()
            .doOnErrorWithDefaultErrorHandler { true }
            .unsafeSubscribeBy(
                onNext = {
                    _userCount.postValue(it.data)
                },
                onError = {
//                    toast("获取动态等信息异常")
                }
            )
    }

    fun getUserUncheckedPraiseCount() {
        val sp = defaultSp
        val lastCheckTimeStamp = sp.getLong(UNCHECK_PRAISE_KEY, 0L)
        if (lastCheckTimeStamp == 0L) return
        apiService.getUncheckedPraiseCount(lastCheckTimeStamp)
            .setSchedulers()
            .doOnErrorWithDefaultErrorHandler { true }
            .unsafeSubscribeBy(
                onNext = {
                    _userUncheckCount.postValue(it.data)
                },
                onError = {
//                    appContext.toast("获取评论等信息异常")
                }
            )
    }

    fun getUserUncheckedCommentCount() {
        val sp = defaultSp
        val lastCheckTimeStamp = sp.getLong(UNCHECK_COMMENT_KEY, 0L)
        if (lastCheckTimeStamp == 0L) return
        apiService.getUncheckedCommentCount(lastCheckTimeStamp)
            .setSchedulers()
            .doOnErrorWithDefaultErrorHandler { true }
            .unsafeSubscribeBy(
                onNext = {
                    _userUncheckCount.postValue(it.data)
                },
                onError = {
//                    appContext.toast("获取评论等信息异常")
                }
            )
    }

    fun setViewWidthAndText(textView: TextView, count: Int) {
        if (count == 0) {
            //如果当前的数值已经归零，就不操作了
            if (textView.text == "0") return
            textView.text = "0"
            //加上一个逐渐变大弹出的动画
            val animator = ValueAnimator.ofFloat(1f, 0f)
            animator.duration = 200
            animator.addUpdateListener { va ->
                textView.scaleX = va.animatedValue as Float
                textView.scaleY = va.animatedValue as Float
            }
            animator.interpolator = DecelerateInterpolator()
            animator.start()
            return
        }
        //如果前后数字没有变化就不进行刷新
        val text = getNumber(count)
        if (textView.text == text) return
        textView.visibility = View.VISIBLE

        //加上一个逐渐变大弹出的动画
        val animator = ValueAnimator.ofFloat(0f, 1f)
        animator.duration = 200
        animator.addUpdateListener { va ->
            textView.scaleX = va.animatedValue as Float
            textView.scaleY = va.animatedValue as Float
        }
        animator.interpolator = DecelerateInterpolator()
        animator.start()
    }

    //转换数字为对应字符
    private fun getNumber(number: Int): String = when {
        number in 0..99 -> number.toString()
        number > 99 -> "99+"
        else -> "0"
    }
}