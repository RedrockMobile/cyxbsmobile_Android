package com.cyxbs.pages.mine.page.edit

import androidx.lifecycle.MutableLiveData
import com.cyxbs.components.utils.network.ApiGenerator
import com.cyxbs.components.utils.network.CommonApiService
import com.cyxbs.components.utils.network.DownMessage
import com.cyxbs.components.utils.network.DownMessageParams
import com.cyxbs.components.utils.network.api
import com.cyxbs.pages.mine.network.ApiService
import com.cyxbs.pages.mine.util.apiService
import com.cyxbs.pages.mine.util.widget.ExecuteOnceObserver
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import okhttp3.MultipartBody
import okhttp3.RequestBody
import java.util.concurrent.TimeUnit

/**
 * Created by zia on 2018/8/26.
 */
class EditViewModel : com.mredrock.cyxbs.lib.base.ui.BaseViewModel() {

    val upLoadImageEvent = MutableLiveData<Boolean>()

    fun uploadAvatar(
        requestBody: RequestBody,
        file: MultipartBody.Part
    ) {
        ApiService::class.api
            .uploadSocialImg(requestBody, file)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .doOnError { upLoadImageEvent.postValue(false) }
            .safeSubscribeBy {
                upLoadImageEvent.postValue(true)
                apiService.updateUserImage(it.data.thumbnail_src, it.data.photosrc)
            }
    }

    val portraitAgreementList: MutableList<DownMessage.DownMessageText> = mutableListOf()

    fun getPortraitAgreement(successCallBack: () -> Unit) {
        val key = "zscy-portrait-agreement"
        val time = System.currentTimeMillis()
        ApiGenerator.getCommonApiService(CommonApiService::class.java)
            .getDownMessage(DownMessageParams(key))
            .subscribeOn(Schedulers.io())
            //有时候网路慢会转一下圈圈，但是有时候网络快，圈圈就像是闪了一下，像bug，就让它最少转一秒吧
            .delay((1000 - (System.currentTimeMillis() - time)).coerceAtLeast(0), TimeUnit.MILLISECONDS)
            .observeOn(AndroidSchedulers.mainThread())
            .toObservable()
            .subscribe(ExecuteOnceObserver(
                onExecuteOnceNext = {
                    portraitAgreementList.clear()
                    portraitAgreementList.addAll(it.data.textList)
                    successCallBack()
                }
            ))
    }


}