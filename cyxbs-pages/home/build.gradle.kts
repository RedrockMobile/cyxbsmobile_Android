plugins {
  id("manager.composeLib")
}

// 测试使用，设置 module_main 暂时不依赖的模块
val excludeList = mutableListOf<String>(

)

useARouter()

kotlin {
  sourceSets {
    // 依赖所有模块
    androidMain.dependencies {
      // 根 gradle 中包含的所有子模块
      project.rootProject.subprojects.filter {
        it.name !in excludeList
            && it != project
            && it.name != "module_app" // module_app 依赖 module_main，而不是反向依赖
            && it.name != "lib_single" // lib_single 只跟单模块调试有关，单模块编译时单独依赖
            && it.name != "lib_debug" // lib_debug 单独依赖
            && it.name != "module_main" // lib_debug 单独依赖
            && !it.path.contains("cyxbs-applications")
            && !it.name.startsWith("cyxbs-")
      }.forEach {
        api(it)
      }
    }
  }
}

dependencies {
  debugImplementation(projects.libDebug)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
}


