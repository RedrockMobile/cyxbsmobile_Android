package com.cyxbs.pages.login.bean

import kotlinx.serialization.Serializable

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/11
 */
@Serializable
class LoginBean(
  val token: String,
  val refreshToken: String,
)

@Serializable
class LoginFailureBean(
  val data: String = "",
  val status: Int = 0,          // 20004: 账号密码错误; 40004: 多次登录失败被锁 15 分钟
  val errcode: Int = 0,         // 后端旧逻辑。10010: 未注册账号;
  val errmessage: String = "",  // 后端旧逻辑
)