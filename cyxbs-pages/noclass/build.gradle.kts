plugins {
  id("manager.composeLib")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.account.api)
      implementation(projects.cyxbsPages.store.api)
      implementation(projects.cyxbsPages.affair.api)
      implementation(projects.cyxbsPages.course.api)
      implementation(projects.cyxbsPages.course.widget)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
    }
  }
}



