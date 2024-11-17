plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.moduleAffair.apiAffair)

  implementation(libs.rxjava)
}
