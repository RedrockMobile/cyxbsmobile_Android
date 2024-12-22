plugins {
  id("manager.library")
}

kotlin {
  sourceSets {
    androidMain.dependencies {
      api(libs.autoService)
    }
  }
}

