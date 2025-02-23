package com.cyxbs.components.utils.utils.judge

import com.cyxbs.components.utils.network.ApiStatus
import com.cyxbs.components.utils.network.HttpClientNoToken
import io.ktor.client.call.body
import io.ktor.client.plugins.HttpRequestTimeoutException
import io.ktor.client.plugins.ServerResponseException
import io.ktor.client.request.get
import kotlinx.io.IOException
import kotlin.coroutines.cancellation.CancellationException

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/18
 */
object RedrockNetwork {

  /**
   * 用于 ping 一下网校后端的网络，用于测试当前后端是否寄掉
   *
   * @return 如果返回 null，则说明是网络连接异常，此时无法确认后端是否寄掉
   */
  suspend fun tryPingNetWork(): Result<ApiStatus>? {
    try {
      val result = HttpClientNoToken.get("/magipoke/ping").body<ApiStatus>()
      return Result.success(result)
    } catch (e: CancellationException) {
      throw e
    } catch (e: HttpRequestTimeoutException) {
      return Result.failure(e) // 请求超时，可理解为后端已崩
    } catch (e: ServerResponseException) {
      return Result.failure(e) // 后端返回状态码 500
    } catch (e: IOException) {
      if (e.message?.startsWith("Unable to resolve host") == true) {
        return null // 无法解析域名，此时说明网络连接异常
      }
      return Result.failure(e)
    } catch (e: Throwable) {
      return Result.failure(e)
    }
  }
}