package com.cyxbs.components.utils.network

import io.ktor.client.HttpClientConfig
import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.engine.darwin.Darwin

/**
 *
 *
 * @author 985892345
 * @date 2025/1/5
 */
internal actual fun createHttpClientEngine(): HttpClientEngine = Darwin.create {

}

internal actual fun HttpClientConfig<*>.platformConfigHttpClient() {
}