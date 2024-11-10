plugins {
  id("manager.libraryApp")
}

useARouter()

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libBase)
  implementation(projects.libUtils)
  implementation(projects.libConfig)

  // 这里面写只有自己模块才会用到的依赖
  implementation(libs.androidx.appcompat)
  implementation(libs.androidx.constraintlayout)
  implementation(libs.gson)// 用于序列化Throwable
}
