plugins {
  id("manager.composeLib")
}

useARouter()
useRoom(rxjava = true)


kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.libUtils)
      implementation(projects.libConfig)
      implementation(projects.libAccount.apiAccount)
      implementation(projects.cyxbsPages.affair.api)
      implementation(projects.cyxbsPages.login.api)
      implementation(projects.moduleCourse.apiCourse)

      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)

      implementation(libs.wheelView)
    }
  }
}

