plugins {
  id("manager.library")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libUtils)
      implementation(projects.cyxbsPages.affair.api)
    }
    androidMain.dependencies {
      implementation(libs.rxjava)
    }
  }
}
