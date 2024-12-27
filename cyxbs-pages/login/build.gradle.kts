plugins {
  id("manager.composeLib")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      subprojects.forEach { implementation(it) }
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsFunctions.update.api)
      implementation(projects.cyxbsComponents.account.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.lottie)
      implementation(libs.glide)
    }
  }
}