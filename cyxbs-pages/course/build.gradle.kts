plugins {
  id("manager.composeLib")
}

useARouter()
useRoom(rxjava = true)

kotlin {
  sourceSets {
    commonMain.dependencies {
      subprojects.forEach { implementation(it) }
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
      implementation(projects.libAccount.apiAccount)
      implementation(projects.cyxbsPages.affair.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.slideShow)
    }
  }
}


