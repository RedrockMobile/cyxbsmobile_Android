package com.cyxbs.components.account.bean

import kotlinx.serialization.Serializable

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/11
 */
@Serializable
class TokenBean(
  val token: String,
  val refreshToken: String,
)