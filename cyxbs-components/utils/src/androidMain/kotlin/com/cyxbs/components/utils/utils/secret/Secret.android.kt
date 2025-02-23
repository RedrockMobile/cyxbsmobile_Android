package com.cyxbs.components.utils.utils.secret

import android.util.Base64
import java.nio.charset.StandardCharsets

/**
 * .
 *
 * @author 985892345
 * @date 2025/1/11
 */

private val IsSupportEncrypt = try {
  SerialAESEncryptor.encrypt("abc".toByteArray(StandardCharsets.UTF_8))
  true
} catch (e: Exception) {
  e.printStackTrace()
  false
}

actual fun secretEncrypt(input: String): String {
  if (!IsSupportEncrypt) return input
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

actual fun secretDecrypt(input: String): String {
  if (!IsSupportEncrypt) return input
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