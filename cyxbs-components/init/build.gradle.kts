plugins {
  id("manager.composeLib")
}

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(libs.autoService)
    }
  }
}

