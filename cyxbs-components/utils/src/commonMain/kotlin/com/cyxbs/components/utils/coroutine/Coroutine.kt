package com.cyxbs.components.utils.coroutine

import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlin.coroutines.cancellation.CancellationException

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/28
 */

/**
 * 应用级别的协程作用域
 */
expect val appCoroutineScope: CoroutineScope

/**
 * 默认协程异常处理
 * ```
 * viewModelScope.launch(EmptyCoroutineExceptionHandler) {
 *   // ...
 * }
 * ```
 */
val EmptyCoroutineExceptionHandler = CoroutineExceptionHandler { _, _ -> }

inline fun <T, R> T.runCatchingCoroutine(block: T.() -> R): Result<R> {
  return try {
    Result.success(block())
  } catch (e: CancellationException) {
    throw e // 协程的取消需要抛出
  } catch (e: Throwable) {
    Result.failure(e)
  }
}
