plugins {
  id("manager.libraryApp")
}

useARouter()
useDataBinding()

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleSport.apiSport)
  implementation(projects.moduleLogin.apiLogin)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.smartRefreshLayout)
  implementation(libs.dialog)
}