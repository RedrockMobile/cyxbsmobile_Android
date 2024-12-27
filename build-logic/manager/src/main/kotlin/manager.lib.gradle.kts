import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import rule.ModuleNamespaceCheckRule

plugins {
  id("com.android.library")
  kotlin("multiplatform") // 为了让 compose 插件好引入该插件，所以这里不使用 kotlin("android")
}

AndroidProjectChecker.config(project) // 项目检查工具

android {
  namespace = ModuleNamespaceCheckRule.getCorrectNamespace(project)
  compileSdk = libsEx.versions.`android-compileSdk`.toInt()
  defaultConfig {
    minSdk = libsEx.versions.`android-minSdk`.toInt()
  }
  compileOptions {
    val javaVersion = libsEx.versions.javaTarget
    sourceCompatibility = JavaVersion.toVersion(javaVersion)
    targetCompatibility = JavaVersion.toVersion(javaVersion)
  }
  lint {
    abortOnError = false // 编译遇到错误不退出，可以一次检查多个错误，并且已执行的 task 下次执行会直接走缓存
    targetSdk = libsEx.versions.`android-targetSdk`.toInt()
  }
  // 命名规范设置，因为多模块相同资源名在打包时会合并，所以必须强制开启
  val paths = project.path.split(":").drop(1)
  if (paths.size == 1) {
    resourcePrefix = project.name.substringAfter("_")
  } else if (paths.first().contains("cyxbs-")) {
    resourcePrefix = project.name
  } else {
    resourcePrefix = paths[paths.size - 2] + "_" + paths.last()
  }
  buildFeatures {
    buildConfig = true
  }
}

kotlin {
  androidTarget {
    compilerOptions {
      jvmTarget.set(JvmTarget.fromTarget(libsEx.versions.kotlinJvmTarget))
    }
  }
}
