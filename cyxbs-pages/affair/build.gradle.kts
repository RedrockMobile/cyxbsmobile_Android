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
      implementation(projects.libUtils)
      implementation(projects.libConfig)
      implementation(projects.libAccount.apiAccount)
      implementation(projects.cyxbsPages.login.api)
      implementation(projects.cyxbsPages.course.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.wheelView)
    }
  }
}

