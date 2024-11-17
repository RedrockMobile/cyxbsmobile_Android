plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(libs.androidx.appcompat)
  implementation(libs.kotlinx.coroutines)
}
