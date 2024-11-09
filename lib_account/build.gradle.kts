plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleLogin.apiLogin)
  implementation(projects.libUtils)
  implementation(projects.libConfig)
  implementation(libs.bundles.network)
  implementation(libs.dialog)
}
