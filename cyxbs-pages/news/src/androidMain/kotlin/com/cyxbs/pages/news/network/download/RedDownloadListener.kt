package com.cyxbs.pages.news.network.download

import android.net.Uri

/**
 * Author: Hosigus
 * Date: 2018/9/23 18:06
 * Description: 下载进度监听
 */
interface RedDownloadListener {
    fun onDownloadStart()
    fun onProgress(currentBytes: Long, contentLength: Long)
    fun onSuccess(uri: Uri?)
    fun onFail(e: Throwable)
}