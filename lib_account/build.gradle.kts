plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libUtils)
  implementation(projects.libConfig)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleLogin.apiLogin)

  implementation(libs.bundles.network)
  implementation(libs.dialog)
}
