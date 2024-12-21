plugins {
  id("manager.libraryApp")
}

useARouter()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.cyxbsPages.store.api)
  implementation(projects.cyxbsPages.affair.api)
  implementation(projects.moduleCourse.apiCourse)
  implementation(projects.moduleCourse.libCourse)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
}


