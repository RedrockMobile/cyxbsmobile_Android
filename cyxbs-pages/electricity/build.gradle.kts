plugins {
  id("manager.composeLib")
}

useARouter()
useAutoService()

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(projects.apiInit)
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
      implementation(projects.libAccount.apiAccount)
      subprojects.forEach { implementation(it) }

      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.wheelPicker)
    }
  }
}


