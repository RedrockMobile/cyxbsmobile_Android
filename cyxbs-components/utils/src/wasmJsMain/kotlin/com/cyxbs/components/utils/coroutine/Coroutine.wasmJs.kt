package com.cyxbs.components.utils.coroutine

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.SupervisorJob

/**
 * 应用级别的协程作用域
 */
actual val appCoroutineScope: CoroutineScope = CoroutineScope(SupervisorJob())