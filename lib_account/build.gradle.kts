plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libUtils)
  implementation(projects.libConfig)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.cyxbsPages.login.api)

  implementation(libs.bundles.network)
  implementation(libs.dialog)
}
