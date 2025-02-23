package com.cyxbs.pages.login.viewmodel

import androidx.compose.runtime.snapshotFlow
import com.cyxbs.components.base.BaseApp
import com.cyxbs.components.utils.utils.judge.NetworkUtil
import com.cyxbs.pages.login.bean.DeviceInfoParams
import com.cyxbs.pages.login.bean.LoginBean
import com.cyxbs.pages.login.network.LoginApiService
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/31
 */
actual class LoginViewModel actual constructor(): CommonLoginViewModel() {

  private val _event = MutableSharedFlow<Event>()
  val event: SharedFlow<Event> get() = _event

  init {
    snapshotFlow { isLoginAnim.value }.collectLaunch {
      if (it) {
        _event.emit(Event.HideSoftInput)
      }
    }
  }

  override suspend fun onLoginSuccess(username: String, bean: LoginBean) {
    super.onLoginSuccess(username, bean)
    _event.emit(Event.Login(true))
    postDeviceInfo()
  }

  override suspend fun onLoginFailure(throwable: Throwable) {
    super.onLoginFailure(throwable)
    _event.emit(Event.Login(false))
  }

  override fun clickForgetPassword() {
    launch {
      _event.emit(Event.ClickForgetPassword)
    }
  }

  override fun clickUserAgreement() {
    launch {
      _event.emit(Event.ClickUserAgreement)
    }
  }

  override fun clickPrivacyPolicy() {
    launch {
      _event.emit(Event.ClickPrivacyPolicy)
    }
  }

  override fun enterTouristMode() {
    launch {
      _event.emit(Event.Login(null))
    }
  }

  override fun clickDisagreeUserAgreement() {
    launch {
      _event.emit(Event.ClickDisagreeUserAgreement)
    }
  }

  private fun postDeviceInfo() {
    /**
     * 登录后向后端发送一次登录时的设备信息以及wifi的ip，用于在校园网登录时能进行定位，防止有人乱登录搞出事故
     * 如果连接方式为流量或者无法获取到wifi的ip，则直接上传 null 即可
     */
    var ipAddress: String? = null
    //检测网络的连接方式
    NetworkUtil.checkCurrentNetworkType()?.let {
      //如果是通过wifi连接，则尝试获取wifi的ip
      if (!it) {
        ipAddress = NetworkUtil.getWifiIPAddress()
      }
    }
    launch {
      //上传设备以及ip信息
      LoginApiService.INSTANCE.recordDeviceInfo(
        DeviceInfoParams(
          BaseApp.getAndroidID(),
          BaseApp.getDeviceModel(),
          ipAddress
        )
      )
    }
  }

  /**
   * 登录界面所有事件收口处
   */
  sealed interface Event {
    data object HideSoftInput: Event
    data class Login(val result: Boolean?) : Event
    data object ClickForgetPassword : Event
    data object ClickUserAgreement : Event
    data object ClickPrivacyPolicy : Event
    data object ClickDisagreeUserAgreement : Event
  }
}