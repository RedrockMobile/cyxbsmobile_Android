plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleDialog.apiDialog)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.dialog)
  implementation(libs.photoView)
  implementation(libs.slideShow)
  implementation(libs.rhino)
}
