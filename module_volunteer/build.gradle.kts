plugins {
  id("manager.library")
}

useARouter()
useAutoService()

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleVolunteer.apiVolunteer)
  implementation(projects.cyxbsPages.store.api)
  implementation(projects.cyxbsPages.store.api)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.lottie)
  implementation(libs.eventBus)
}

