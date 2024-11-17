package com.mredrock.cyxbs.lib.utils.network

import com.alibaba.sdk.android.httpdns.HttpDns
import com.alibaba.sdk.android.httpdns.InitConfig
import com.alibaba.sdk.android.httpdns.RequestIpType
import com.google.auto.service.AutoService
import com.mredrock.cyxbs.init.InitialManager
import com.mredrock.cyxbs.init.InitialService
import com.mredrock.cyxbs.lib.utils.extensions.appContext
import okhttp3.Dns
import java.net.InetAddress

/**
 * ... httpdns解析域名,由运维统一下发
 * @author RQ527 (Ran Sixiang)
 * @email 1799796122@qq.com
 * @date 2023/9/13
 * @Description:
 */
object OkHttpDnsService {

  //阿里云httpDns账号id，由运维统一管理
  private const val ACCOUNT_ID = "137074"

  //预加载域名
  private val PRE_LOAD_ADDRESS = listOf(END_POINT_REDROCK_PROD, END_POINT_REDROCK_DEV)

  init {
    HttpDns.init(
      ACCOUNT_ID,
      InitConfig.Builder()
        .setEnableHttps(true) // 配置是否启用https，默认http
        .setEnableCacheIp(true) // 配置是否启用本地缓存，默认不启用
        .setEnableExpiredIp(true) // 配置是否允许返回过期IP，默认允许
        .build()
    )
  }

  private val httpService = HttpDns.getService(
    appContext,
    ACCOUNT_ID
  ).apply {
    setPreResolveHosts(PRE_LOAD_ADDRESS) // 触发域名的提前解析
  }

  val dns = object : Dns {
    override fun lookup(hostname: String): List<InetAddress> {
      val ipv4s = runCatching {
        httpService.getHttpDnsResultForHostSyncNonBlocking(
          hostname,
          RequestIpType.v4
        ).ips.map { InetAddress.getAllByName(it).asList() }.flatten()
      }.getOrDefault(emptyList())
      val ipv6s = runCatching {
        httpService.getHttpDnsResultForHostSyncNonBlocking(
          hostname,
          RequestIpType.v6
        ).ips.map { InetAddress.getAllByName(it).asList() }.flatten()
      }.getOrDefault(emptyList())
      // 优先走 ipv4，然后走 ipv6，如果都为空，则走系统解析
      return (ipv4s + ipv6s).ifEmpty { Dns.Companion.SYSTEM.lookup(hostname) }
    }
  }
}

@AutoService(InitialService::class)
class OkHttpDnsInitialService : InitialService {
  override fun onMainProcess(manager: InitialManager) {
    super.onMainProcess(manager)
    OkHttpDnsService.dns // 触发类初始化，让域名提前解析
  }
}