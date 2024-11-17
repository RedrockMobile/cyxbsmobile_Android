plugins {
  id("manager.library")
}

useARouter()
useAutoService()

dependencies {
  implementation(projects.apiInit)
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

