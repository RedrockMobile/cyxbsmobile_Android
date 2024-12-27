package com.cyxbs.pages.schoolcar

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.cyxbs.pages.schoolcar.bean.MapLines
import com.cyxbs.pages.schoolcar.database.MapInfoDataBase
import com.cyxbs.pages.schoolcar.network.ApiService
import com.mredrock.cyxbs.lib.base.ui.BaseViewModel
import com.cyxbs.components.utils.extensions.setSchedulers
import com.cyxbs.components.utils.network.ApiGenerator
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 *@Author:SnowOwlet
 *@Date:2022/5/11 21:28
 *
 */
class SchoolDetailViewModel : BaseViewModel() {

  private val apiService = ApiGenerator.getApiService(ApiService::class.java)
  private val _mapInfo = MutableLiveData<MapLines>()
  val mapInfo: LiveData<MapLines>
    get() = _mapInfo

  fun initMapInfo() {
    MapInfoDataBase.INSTANCE.mapInfoDao().queryMapLines()
      .toObservable()
      .setSchedulers(observeOn = Schedulers.io())
      .safeSubscribeBy(
        onNext = { mapLines ->
          _mapInfo.postValue(mapLines)
        }
      )
    //拿取车站等信息版本号
    apiService.schoolSiteVersion()
      .setSchedulers(observeOn = Schedulers.io())
      .safeSubscribeBy(
        onNext = { version ->
          MapInfoDataBase.INSTANCE.mapInfoDao().queryMapLines()
            .subscribeOn(Schedulers.io())
            .subscribe(
              {
                if (it.version != version.data.version) {
                  getMapLinesByNet()
                }
              },{
                getMapLinesByNet()
              })
        }
      )
  }

  private fun getMapLinesByNet(){
    apiService.schoolSite()
      .setSchedulers(observeOn = Schedulers.io())
      .safeSubscribeBy(
        onNext = { mapLines ->
          mapLines.data.let { res -> _mapInfo.postValue(res) }
          MapInfoDataBase.INSTANCE.mapInfoDao().insertMapLines(mapLines.data)
        },
        onError = {

        }
      )
  }

}