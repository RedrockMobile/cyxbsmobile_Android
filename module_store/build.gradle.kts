plugins {
  id("manager.libraryApp")
}

useARouter()
useDataBinding()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleStore.apiStore)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.glide)
  implementation(libs.photoView)
  implementation(libs.slideShow)
}
