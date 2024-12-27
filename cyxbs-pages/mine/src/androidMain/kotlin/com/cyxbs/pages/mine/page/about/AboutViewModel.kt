package com.cyxbs.pages.mine.page.about

import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.CommonApiService
import com.cyxbs.components.utils.network.DownMessage
import com.cyxbs.components.utils.network.DownMessageParams
import com.cyxbs.pages.mine.util.widget.ExecuteOnceObserver
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import java.util.concurrent.TimeUnit

/**
 * Created by roger on 2020/4/8
 */
class AboutViewModel : BaseViewModel() {

    val featureIntroList: MutableList<DownMessage.DownMessageText> = mutableListOf()

    fun getFeatureIntro(packageName: String, successCallBack: () -> Unit, errorCallback: () -> Unit) {
        val time = System.currentTimeMillis()
        ApiGenerator.getCommonApiService(CommonApiService::class.java)
                .getDownMessage(DownMessageParams(packageName))
                .subscribeOn(Schedulers.io())
                //有时候网路慢会转一下圈圈，但是有时候网络快，圈圈就像是闪了一下，像bug，就让它最少转一秒吧
                .delay((1000 - (System.currentTimeMillis() - time)).coerceAtLeast(0), TimeUnit.MILLISECONDS)
                .observeOn(AndroidSchedulers.mainThread())
                .toObservable()
                .subscribe(ExecuteOnceObserver(
                        onExecuteOnceNext = {
                            featureIntroList.clear()
                            featureIntroList.addAll(it.data.textList)
                            successCallBack()
                        },
                        onExecuteOnceError = {
                            errorCallback()
                        }
                ))
    }
}