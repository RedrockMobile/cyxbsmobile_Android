plugins {
  id("manager.libraryApp")
}

useARouter()
useRoom(rxjava = true)

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libCrash.apiCrash)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleCourse.apiCourse)
  implementation(projects.moduleCourse.libCourse)
  implementation(projects.moduleAffair.apiAffair)
  implementation(projects.moduleWidget.apiWidget)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)

  implementation(libs.slideShow)
}

