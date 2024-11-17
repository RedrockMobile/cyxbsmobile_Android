package com.mredrock.cyxbs.lib.utils.extensions

import com.google.gson.Gson
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.json.Json

/**
 * .
 *
 * @author 985892345
 * @date 2024/11/10
 */

@OptIn(ExperimentalSerializationApi::class)
val JsonDefault = Json {
  encodeDefaults = false // 需要编码默认值
  ignoreUnknownKeys = true // 忽略未知键
  isLenient = true // 宽松模式，允许键和字符串值不带引号
  allowTrailingComma = true // 允许尾随逗号
}

val GsonDefault = Gson()