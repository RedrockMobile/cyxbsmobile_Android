plugins {
  id("manager.library")
}

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsPages.course.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)

      api(libs.netLayout)
    }
  }
}
