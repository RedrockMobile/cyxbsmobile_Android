package com.cyxbs.components.account.utils

import android.os.Build
import com.cyxbs.components.account.utils.InsecureSHA1PRNGKeyDerivator.Companion.deriveInsecureKey
import java.nio.charset.StandardCharsets
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

/**
 * @author Haruue Icymoon haruue@caoyue.com.cn
 */
object SerialAESEncryptor {

  private val keySpec by lazy {
    var key = Build.SERIAL
    if (key == null || key == "") {
      key = "huQVa6y^Rd0Z^e#K"
    }
    while (key.length < 16) {
      key += key
    }
    val keyBytes = key.toByteArray(StandardCharsets.US_ASCII)
    SecretKeySpec(deriveInsecureKey(keyBytes, 16), "AES")
  }
  private val cipher = Cipher.getInstance("AES")
  private val encryptCipher = cipher.apply {
    init(Cipher.ENCRYPT_MODE, keySpec, IvParameterSpec(ByteArray(blockSize)))
  }
  private val decryptCipher = cipher.apply {
    init(Cipher.DECRYPT_MODE, keySpec, IvParameterSpec(ByteArray(blockSize)))
  }

  fun encrypt(orig: ByteArray): ByteArray {
    try {
      return encryptCipher.doFinal(orig)
    } catch (e: Exception) {
      throw RuntimeException("encrypt failure", e)
    }
  }

  fun decrypt(encrypted: ByteArray): ByteArray {
    try {
      return decryptCipher.doFinal(encrypted)
    } catch (e: Exception) {
      throw RuntimeException("decrypt failure", e)
    }
  }
}
