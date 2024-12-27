plugins {
  id("manager.composeLib")
}

// 测试使用，设置 module_main 暂时不依赖的模块
val excludeList = mutableListOf<String>(

)

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      // 根 gradle 中包含的所有子模块
      project.rootProject.subprojects.filter {
        it.name !in excludeList
            && it != project
            && it.name != "debug" // lib_debug 单独依赖
            && !it.path.contains("cyxbs-applications")
            && !it.name.startsWith("cyxbs-")
      }.forEach {
        api(it)
      }
    }
    // 依赖所有模块
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
    }
  }
}

dependencies {
  debugImplementation(projects.cyxbsFunctions.debug)
}

