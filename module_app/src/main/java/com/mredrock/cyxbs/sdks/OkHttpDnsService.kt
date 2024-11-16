package com.mredrock.cyxbs.sdks

import android.annotation.SuppressLint
import com.alibaba.sdk.android.httpdns.HttpDns
import com.google.auto.service.AutoService
import com.mredrock.cyxbs.init.InitialManager
import com.mredrock.cyxbs.init.InitialService
import com.mredrock.cyxbs.lib.base.BaseApp
import com.mredrock.cyxbs.lib.utils.network.INetworkConfigService
import okhttp3.OkHttpClient
import java.net.InetAddress

/**
 * ... httpdns解析域名,由运维统一下发
 * @author RQ527 (Ran Sixiang)
 * @email 1799796122@qq.com
 * @date 2023/9/13
 * @Description:
 */
class OkHttpDnsService : INetworkConfigService, InitialService {

  @SuppressLint("CheckResult")
  companion object {
    //阿里云httpDns账号id，由运维统一管理
    private const val ACCOUNT_ID = "137074"

    //预加载域名
    private val PRE_LOAD_ADDRESS =
      arrayListOf("be-dev.redrock.cqupt.edu.cn", "be-prod.redrock.cqupt.edu.cn")

    init {
      HttpDns.init(
        ACCOUNT_ID,
        com.alibaba.sdk.android.httpdns.InitConfig.Builder()
          .setEnableHttps(true) // 配置是否启用https，默认http
          .setEnableCacheIp(true) // 配置是否启用本地缓存，默认不启用
          .setEnableExpiredIp(true) // 配置是否允许返回过期IP，默认允许
          .build()
      )
    }

    val httpService = HttpDns.getService(BaseApp.baseApp, ACCOUNT_ID).apply {
      setPreResolveHosts(PRE_LOAD_ADDRESS) // 触发域名的提前解析
    }
  }

  override fun onCreateOkHttp(builder: OkHttpClient.Builder) {
    builder.dns(object : okhttp3.Dns {
      override fun lookup(hostname: String): List<InetAddress> {
        val ipv4s = runCatching {
          httpService.getHttpDnsResultForHostSyncNonBlocking(
            hostname,
            com.alibaba.sdk.android.httpdns.RequestIpType.v4
          ).ips.map { InetAddress.getAllByName(it).asList() }.flatten()
        }.getOrDefault(emptyList())
        val ipv6s = runCatching {
          httpService.getHttpDnsResultForHostSyncNonBlocking(
            hostname,
            com.alibaba.sdk.android.httpdns.RequestIpType.v6
          ).ips.map { InetAddress.getAllByName(it).asList() }.flatten()
        }.getOrDefault(emptyList())
        // 优先走 ipv4，然后走 ipv6，如果都为空，则走系统解析
        return (ipv4s + ipv6s).ifEmpty { okhttp3.Dns.Companion.SYSTEM.lookup(hostname) }
      }
    })
  }
}

@AutoService(InitialService::class)
class OkHttpDnsInitialService : InitialService {
  override fun onMainProcess(manager: InitialManager) {
    super.onMainProcess(manager)
    OkHttpDnsService.httpService // 触发类初始化，让域名提前解析
  }
}