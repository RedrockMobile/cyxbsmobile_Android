package com.cyxbs.components.utils

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/29
 */
actual fun isDebug(): Boolean {
  return true // todo 后续再配置，考虑使用 buildConfig 插件生成 https://github.com/gmazzo/gradle-buildconfig-plugin
}