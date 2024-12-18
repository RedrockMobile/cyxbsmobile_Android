plugins {
  id("manager.libraryApp")
}

useARouter()
useRoom(rxjava = true)

dependencies {
  implementation(projects.libBase)
  implementation(projects.libUtils)
  implementation(projects.libConfig)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleAffair.apiAffair)
  implementation(projects.cyxbsPages.login.api)
  implementation(projects.moduleCourse.apiCourse)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)

  implementation(libs.wheelView)
}
