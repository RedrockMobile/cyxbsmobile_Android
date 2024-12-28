plugins {
  id("manager.app")
}

useKtProvider()

kotlin {
  sourceSets {
    commonMain.dependencies {
      // home 模块去依赖了其他模块，所以这里只依赖 home
      implementation(projects.cyxbsPages.home)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
    }
  }
}