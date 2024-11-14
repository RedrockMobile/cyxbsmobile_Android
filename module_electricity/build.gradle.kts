plugins {
  id("manager.library")
}

//dependLibCommon() // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块

useARouter()

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libCommon)
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleElectricity.apiElectricity)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.wheelPicker)
}

