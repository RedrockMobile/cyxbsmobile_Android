plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.cyxbsPages.affair.api)

  implementation(libs.rxjava)
}
