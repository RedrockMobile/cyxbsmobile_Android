plugins {
  id("manager.library")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
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
    }
  }
}


