package com.cyxbs.components.utils.utils.secret

import android.os.Build
import com.cyxbs.components.utils.utils.secret.InsecureSHA1PRNGKeyDerivator.Companion.deriveInsecureKey
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

  fun encrypt(orig: ByteArray): ByteArray {
    try {
      val cipher = Cipher.getInstance("AES")
      cipher.init(Cipher.ENCRYPT_MODE, keySpec, IvParameterSpec(ByteArray(cipher.blockSize)))
      return cipher.doFinal(orig)
    } catch (e: Exception) {
      throw RuntimeException("encrypt failure", e)
    }
  }

  fun decrypt(encrypted: ByteArray): ByteArray {
    try {
      val cipher = Cipher.getInstance("AES")
      cipher.init(Cipher.DECRYPT_MODE, keySpec, IvParameterSpec(ByteArray(cipher.blockSize)))
      return cipher.doFinal(encrypted)
    } catch (e: Exception) {
      throw RuntimeException("decrypt failure", e)
    }
  }
}
