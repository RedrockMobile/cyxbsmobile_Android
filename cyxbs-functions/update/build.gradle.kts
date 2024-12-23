plugins {
  id("manager.library")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      subprojects.forEach { implementation(it) }
      implementation(projects.libUtils)
    }
    androidMain.dependencies {
      implementation(libs.bundles.network)
      implementation(libs.dialog)
      implementation(libs.rxpermissions)
    }
  }
}

