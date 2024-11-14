plugins {
  id("manager.libraryApp")
}

useARouter()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.moduleSport.apiSport)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.glide)
}