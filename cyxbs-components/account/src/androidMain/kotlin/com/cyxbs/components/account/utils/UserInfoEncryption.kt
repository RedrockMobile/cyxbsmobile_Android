package com.cyxbs.components.account.utils

import android.util.Base64
import java.nio.charset.StandardCharsets

/**
 * @author Haruue Icymoon haruue@caoyue.com.cn
 */
class UserInfoEncryption {
  private var isSupportEncrypt = true

  init {
    try {
      SerialAESEncryptor.encrypt("abc".toByteArray(StandardCharsets.UTF_8))
    } catch (e: Exception) {
      e.printStackTrace()
      isSupportEncrypt = false
    }
  }

  fun encrypt(json: String): String {
    if (!isSupportEncrypt) return json
    return try {
      Base64.encodeToString(
        SerialAESEncryptor.encrypt(json.toByteArray(StandardCharsets.UTF_8)),
        Base64.DEFAULT
      )
    } catch (e: Exception) {
      e.printStackTrace()
      json
    }
  }

  fun decrypt(base64Encrypted: String): String {
    if (base64Encrypted == "") return ""
    if (!isSupportEncrypt) return base64Encrypted
    return try {
      String(
        SerialAESEncryptor.decrypt(
          Base64.decode(
            base64Encrypted,
            Base64.DEFAULT
          )
        ), StandardCharsets.UTF_8
      )
    } catch (e: Exception) {
      e.printStackTrace()
      ""
    }
  }
}
