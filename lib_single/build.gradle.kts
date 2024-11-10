plugins {
  id("manager.library")
}

useARouter(false)

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleLogin.apiLogin)

  implementation(libs.androidx.appcompat)
}

