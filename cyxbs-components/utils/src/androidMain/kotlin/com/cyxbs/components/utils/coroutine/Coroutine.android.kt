package com.cyxbs.components.utils.coroutine

import androidx.lifecycle.coroutineScope
import com.cyxbs.components.utils.extensions.appLifecycle
import kotlinx.coroutines.CoroutineScope

/**
 * .
 *
 * @author 985892345
 * @date 2024/12/28
 */
actual val appCoroutineScope: CoroutineScope
  get() = appLifecycle.coroutineScope