package com.cyxbs.components.account.provider

import com.cyxbs.components.config.sp.defaultSettings
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

/**
 * 游客状态提供
 *
 * @author 985892345
 * @date 2025/1/18
 */
internal object TouristProvider {
  private const val KEY = "is_tourist"

  private val _stateFlow = MutableStateFlow(defaultSettings.getBoolean(KEY, false))
  val stateFlow: StateFlow<Boolean> = _stateFlow

  fun set(isTourist: Boolean) {
    _stateFlow.value = isTourist
    defaultSettings.putBoolean(KEY, isTourist)
  }
}