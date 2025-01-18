package com.cyxbs.components.account

import com.cyxbs.components.account.api.AccountState
import com.cyxbs.components.account.api.IAccountEditService
import com.cyxbs.components.account.api.IAccountService
import com.cyxbs.components.account.api.UserInfo
import com.cyxbs.components.account.bean.TokenBean
import com.cyxbs.components.account.provider.AccountStateProvider
import com.cyxbs.components.account.provider.TokenProvider
import com.cyxbs.components.account.provider.TouristProvider
import com.cyxbs.components.account.provider.UserInfoProvider
import com.g985892345.provider.api.annotation.ImplProvider
import kotlinx.coroutines.flow.StateFlow

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/11
 */
@ImplProvider(clazz = IAccountService::class)
@ImplProvider(clazz = IAccountEditService::class)
object AccountService : IAccountService, IAccountEditService {

  override val userInfo: StateFlow<UserInfo?>
    get() = UserInfoProvider.stateFlow

  override val state: StateFlow<AccountState>
    get() = AccountStateProvider.stateFlow

  override fun onLoginSuccess(stuNum: String, token: String, refreshToken: String) {
    UserInfoProvider.clear()
    TouristProvider.set(false)
    TokenProvider.set(TokenBean(token = token, refreshToken = refreshToken))
    refreshInfo()
  }

  override fun onLogout() {
    TouristProvider.set(false)
    TokenProvider.clear()
    UserInfoProvider.clear()
  }

  override fun onTouristMode() {
    UserInfoProvider.clear()
    TokenProvider.clear()
    TouristProvider.set(true)
  }

  override fun refreshInfo() {
    UserInfoProvider.refresh()
  }
}



