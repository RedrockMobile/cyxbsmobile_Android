plugins {
  id("manager.library")
}

useARouter(false) // lib_common 模块不包含实现类，不需要处理注解

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.libProtocol.apiProtocol)
  implementation(projects.moduleLogin.apiLogin)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)

  implementation(libs.eventBus)
  implementation(libs.glide)
  implementation(libs.rxpermissions)
  implementation(libs.lPhotoPicker)
  implementation(libs.photoView)
}

