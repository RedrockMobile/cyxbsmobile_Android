package com.cyxbs.pages.mine.page.about

import com.mredrock.cyxbs.common.network.ApiGenerator
import com.mredrock.cyxbs.common.network.CommonApiService
import com.mredrock.cyxbs.common.utils.LogUtils
import com.mredrock.cyxbs.common.utils.down.bean.DownMessageText
import com.mredrock.cyxbs.common.utils.down.params.DownMessageParams
import com.mredrock.cyxbs.common.viewmodel.BaseViewModel
import com.cyxbs.pages.mine.util.widget.ExecuteOnceObserver
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import java.util.concurrent.TimeUnit

/**
 * Created by roger on 2020/4/8
 */
class AboutViewModel : BaseViewModel() {

    val featureIntroList: MutableList<DownMessageText> = mutableListOf()

    fun getFeatureIntro(packageName: String, successCallBack: () -> Unit, errorCallback: () -> Unit) {
        val time = System.currentTimeMillis()
        LogUtils.d("qt", packageName)
        ApiGenerator.getCommonApiService(CommonApiService::class.java)
                .getDownMessage(DownMessageParams(packageName))
                .subscribeOn(Schedulers.io())
                //有时候网路慢会转一下圈圈，但是有时候网络快，圈圈就像是闪了一下，像bug，就让它最少转一秒吧
                .delay((1000 - (System.currentTimeMillis() - time)).coerceAtLeast(0), TimeUnit.MILLISECONDS)
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(ExecuteOnceObserver(
                        onExecuteOnceNext = {
                            featureIntroList.clear()
                            featureIntroList.addAll(it.data.textList)
                            LogUtils.d("AboutViewModel",it.data.textList.toString()+"\n")
                            successCallBack()
                        },
                        onExecuteOnceError = {
                            errorCallback()
                        }
                ))
    }
}