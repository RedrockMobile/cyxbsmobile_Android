plugins {
  id("manager.library")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.androidx.work)
      implementation(libs.dialog)
      implementation(libs.rxpermissions)
      implementation(libs.glide)
      implementation(libs.photoView)
    }
  }
}


