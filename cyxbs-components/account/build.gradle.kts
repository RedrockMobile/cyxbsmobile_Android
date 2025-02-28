plugins {
  id("manager.lib")
}

useKtorfit()
useKtProvider()

kotlin {
  sourceSets {
    commonMain.dependencies {
      subprojects.forEach { implementation(it) }
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsPages.login.api)
      implementation(libs.ktor.core)
    }
    androidMain.dependencies {
      implementation(libs.bundles.network)
      implementation(libs.dialog)
    }
  }
}
