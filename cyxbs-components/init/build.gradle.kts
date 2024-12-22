plugins {
  id("manager.library")
}

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(libs.autoService)
    }
  }
}

