plugins {
  id("manager.library")
}

useARouter()
useAutoService()

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libAccount.apiAccount)
  implementation(libs.androidx.appcompat)
  implementation(libs.androidx.constraintlayout)
  implementation(libs.material)
  implementation(libs.dialog) // 因为要设置 MaterialDialog 主题所以依赖
  implementation(libs.rxjava)
}


