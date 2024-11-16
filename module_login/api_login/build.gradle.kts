plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(libs.kotlinx.coroutines)
}
