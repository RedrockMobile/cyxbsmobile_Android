plugins {
  id("manager.library")
}

useARouter()

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(libs.rxjava)
    }
  }
}
