package com.cyxbs.components.account.api

import kotlinx.coroutines.flow.StateFlow
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/11
 */
interface IAccountService {

  /**
   * 用户信息
   *
   * 如果需要转换为 Observable 来观察学号，则使用
   * ```
   * IAccountService::class.impl().userInfo
   *     .map { it?.stuNum.orEmpty() }
   *     .asObservable()
   * ```
   */
  val userInfo: StateFlow<UserInfo?>

  /**
   * 当前账户状态
   */
  val state: StateFlow<AccountState>

  val stuNum: String?
    get() = userInfo.value?.stuNum

  /**
   * 是否处于登录状态
   */
  fun isLogin(): Boolean = state.value is AccountState.Login

  /**
   * 是否处于游客模式
   */
  fun isTouristMode(): Boolean = state.value is AccountState.Tourist
}

@Serializable
sealed interface AccountState {
  @Serializable
  data object Login : AccountState
  @Serializable
  data object Logout : AccountState
  @Serializable
  data object Tourist : AccountState
}

@Serializable
data class UserInfo(
  @SerialName("gender")
  val gender: String, // 性别
  @SerialName("photo_src")
  val photoSrc: String, // 个人头像
  @SerialName("stunum")
  val stuNum: String, // 学号
  @SerialName("username")
  val username: String, // 用户名字
  @SerialName("college")
  val college: String, // 学院信息
)