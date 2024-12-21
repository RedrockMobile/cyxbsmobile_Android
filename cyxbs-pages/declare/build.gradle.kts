plugins {
  id("manager.composeLib")
}

useARouter()
useDataBinding()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
      implementation(projects.cyxbsPages.store.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.dialog)
    }
  }
}
