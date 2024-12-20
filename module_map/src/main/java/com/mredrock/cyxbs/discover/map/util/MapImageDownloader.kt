package com.mredrock.cyxbs.discover.map.util

import kotlinx.coroutines.suspendCancellableCoroutine
import okhttp3.Call
import okhttp3.MediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okhttp3.ResponseBody
import okio.Buffer
import okio.BufferedSource
import okio.ForwardingSource
import okio.buffer
import java.io.File
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException

/**
 * 地图下载器，需要监听下载进度，所以单独封装
 *
 * @author 985892345
 * @date 2024/12/20
 */
object MapImageDownloader {

  /**
   * 下载图片到 [file] 里，如果下载出现异常，则向外抛出
   * @param listener 监听下载进度
   */
  suspend fun download(
    url: String,
    file: File,
    listener: (bytesRead: Long, contentLength: Long) -> Unit,
  ) {
    val client = OkHttpClient.Builder()
      .addInterceptor { chain ->
        val request = chain.request()
        val response = chain.proceed(request)
        val body = response.body!!
        response.newBuilder().body(ProgressResponseBody(body, listener)).build()
      }
      .build()
    val request = Request.Builder()
      .url(url)
      .build()
    val response = client.newCall(request).awaitResponse()
    try {
      file.outputStream().use { output ->
        response.body!!.byteStream().use { input ->
          input.copyTo(output)
        }
      }
    } catch (e: Exception) {
      // 源文件已经被污染，这里直接 delete
      file.deleteOnExit()
      throw e
    }
  }

  private suspend fun Call.awaitResponse(): Response {
    return suspendCancellableCoroutine { continuation ->
      continuation.invokeOnCancellation {
        cancel()
      }
      runCatching { execute() }.onSuccess {
        continuation.resume(it)
      }.onFailure {
        continuation.resumeWithException(it)
      }
    }
  }
}

// 监听下载进度
class ProgressResponseBody(
  private val responseBody: ResponseBody,
  private val listener: (bytesRead: Long, contentLength: Long) -> Unit,
) : ResponseBody() {

  override fun contentType(): MediaType? {
    return responseBody.contentType()
  }

  override fun contentLength(): Long {
    return responseBody.contentLength()
  }

  override fun source(): BufferedSource {
    return object : ForwardingSource(responseBody.source()) {
      var totalBytesRead = 0L
      override fun read(sink: Buffer, byteCount: Long): Long {
        val bytesRead = super.read(sink, byteCount)
        totalBytesRead += if (bytesRead != -1L) bytesRead else 0
        listener.invoke(totalBytesRead, responseBody.contentLength())
        return bytesRead
      }
    }.buffer()
  }
}