package com.cyxbs.pages.declare.main.page.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.declare.main.bean.HasPermBean
import com.cyxbs.pages.declare.main.bean.VotesBean
import com.cyxbs.pages.declare.main.net.HomeApiService
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.mredrock.cyxbs.lib.utils.network.api
import com.mredrock.cyxbs.lib.utils.network.mapOrInterceptException
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 * ...
 * @author RQ527 (Ran Sixiang)
 * @email 1799796122@qq.com
 * @date 2023/2/4
 * @Description:
 */
class HomeViewModel : BaseViewModel() {

    val homeLiveData: LiveData<List<VotesBean>>
        get() = _mutableHomeLiveData
    private val _mutableHomeLiveData = MutableLiveData<List<VotesBean>>()

    val homeErrorLiveData: LiveData<Boolean>
        get() = _mutableHomeErrorLiveData
    private val _mutableHomeErrorLiveData = MutableLiveData<Boolean>()

    val permLiveData: LiveData<HasPermBean>
        get() = _mutablePermLiveData
    private val _mutablePermLiveData = MutableLiveData<HasPermBean>()

    /**
     * 获取主页数据
     */
    fun getHomeData() {
        HomeApiService::class.api
            .getHomeData()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _mutableHomeErrorLiveData.postValue(true)
            }
            .safeSubscribeBy {
                _mutableHomeErrorLiveData.postValue(false)
                _mutableHomeLiveData.postValue(it)
            }
    }

    /**
     * 获取是否有权限发布投票
     */
    fun hasPerm() {
        HomeApiService::class.api
            .hasAccessPost()
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .mapOrInterceptException {
                _mutableHomeErrorLiveData.postValue(true)
            }
            .safeSubscribeBy {
                _mutableHomeErrorLiveData.postValue(false)
                _mutablePermLiveData.postValue(it)
            }
    }
}