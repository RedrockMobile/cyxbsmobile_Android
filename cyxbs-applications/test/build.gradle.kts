plugins {
  id("manager.composeApp")
}

kotlin {
  sourceSets {
    androidMain.dependencies {
      // module_main 模块去依赖了其他模块，所以这里只依赖 module_main
      implementation(projects.cyxbsPages.home)

      implementation(libs.bundles.projectBase)
    }
  }
}