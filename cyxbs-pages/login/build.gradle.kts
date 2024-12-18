plugins {
  id("manager.composeLib")
}

useARouter()

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
      implementation(projects.libUpdate.apiUpdate)
      implementation(projects.libAccount.apiAccount)
      implementation(projects.libProtocol.apiProtocol)
      implementation(projects.cyxbsPages.login.api)

      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.lottie)
      implementation(libs.glide)
    }
  }
}
