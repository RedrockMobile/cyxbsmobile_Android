plugins {
  id("manager.lib")
  id("kmp.compose")
}

useKtProvider()
useRoom(rxjava = true)


kotlin {
  sourceSets {
    commonMain.dependencies {
      subprojects.forEach { implementation(it) }
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.account.api)
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
