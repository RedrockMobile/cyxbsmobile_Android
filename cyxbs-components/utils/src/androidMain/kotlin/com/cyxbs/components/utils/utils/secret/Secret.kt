package com.cyxbs.components.utils.utils.secret

import android.util.Base64
import java.nio.charset.StandardCharsets

/**
 * @author Haruue Icymoon haruue@caoyue.com.cn
 */
class Secret {

  private var isSupportEncrypt = true

  init {
    try {
      SerialAESEncryptor.encrypt("abc".toByteArray(StandardCharsets.UTF_8))
    } catch (e: Exception) {
      e.printStackTrace()
      isSupportEncrypt = false
    }
  }

  fun encrypt(input: String): String {
    if (!isSupportEncrypt) return input
    return try {
      Base64.encodeToString(
        SerialAESEncryptor.encrypt(input.toByteArray(StandardCharsets.UTF_8)),
        Base64.DEFAULT
      )
    } catch (e: Exception) {
      e.printStackTrace()
      input
    }
  }

  fun decrypt(input: String): String {
    if (!isSupportEncrypt) return input
    return try {
      String(
        SerialAESEncryptor.decrypt(
          Base64.decode(
            input,
            Base64.DEFAULT
          )
        ), StandardCharsets.UTF_8
      )
    } catch (e: Exception) {
      e.printStackTrace()
      input
    }
  }
}
