plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libUtils)
  implementation(projects.libUpdate.apiUpdate)

  implementation(libs.bundles.network)
  implementation(libs.dialog)
  implementation(libs.rxpermissions)
  implementation(libs.retrofit.converter.gson)
}
