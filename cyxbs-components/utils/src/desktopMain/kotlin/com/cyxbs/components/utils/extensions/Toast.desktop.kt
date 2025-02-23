package com.cyxbs.components.utils.extensions

import com.cyxbs.components.config.compose.toast.PlatformToast


actual fun toast(s: CharSequence?) {
  if (s != null) {
    PlatformToast(s, 2000L).show()
  }
}

actual fun toastLong(s: CharSequence?) {
  if (s != null) {
    PlatformToast(s, 3500L).show()
  }
}