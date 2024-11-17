plugins {
  id("manager.library")
}

useARouter()
useDataBinding()

dependencies {
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libBase)
  implementation(projects.libProtocol.apiProtocol)

  implementation(libs.androidx.appcompat)
  implementation(libs.androidx.constraintlayout)
}

