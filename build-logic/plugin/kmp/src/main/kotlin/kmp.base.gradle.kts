import org.jetbrains.kotlin.gradle.ExperimentalWasmDsl
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.targets.js.webpack.KotlinWebpackConfig

plugins {
  kotlin("multiplatform")
}

kotlin {
  androidTarget {
    compilerOptions {
      jvmTarget.set(JvmTarget.fromTarget(libsEx.versions.kotlinJvmTarget))
    }
  }
  if (Multiplatform.enableDesktop(project)) {
    jvm("desktop")
    jvmToolchain(libsEx.versions.kotlinJvmTarget.toInt())
  }
  if (Multiplatform.enableIOS(project)) {
    listOf(
      iosX64(),
      iosArm64(),
      iosSimulatorArm64()
    ).forEach { iosTarget ->
      iosTarget.binaries.framework {
        baseName = Config.getBaseName(project)
        isStatic = true
      }
    }
  }
  if (Multiplatform.enableWasm(project)) {
    @OptIn(ExperimentalWasmDsl::class)
    wasmJs {
      browser {
        val rootDirPath = project.rootDir.path
        val projectDirPath = project.projectDir.path
        commonWebpackConfig {
          devServer = (devServer ?: KotlinWebpackConfig.DevServer()).apply {
            static = (static ?: mutableListOf()).apply {
              // Serve sources to debug inside browser
              add(rootDirPath)
              add(projectDirPath)
            }
          }
        }
      }
    }
  }

  sourceSets {
    commonMain.dependencies {
      implementation(libsEx.`kotlinx-coroutines`)
      implementation(libsEx.`kotlinx-collections`)
      implementation(libsEx.`kotlinx-serialization`) // 想要序列化还需要引入 alias(libs.plugins.kotlinSerialization) 插件
      implementation(libsEx.`kmp-uri`)
      implementation(libsEx.`kmp-settings-core`)
      implementation(libsEx.`kmp-settings-serialization`)
      implementation(libsEx.`kmp-settings-serialization`)
    }
    if (Multiplatform.enableDesktop(project)) {
      val desktopMain by getting {
        dependencies {
          implementation(libsEx.`kotlinx-coroutines-swing`)
        }
      }
    }
    androidMain {
      dependencies {
        implementation(libsEx.`kotlinx-coroutines-android`)
        implementation(libsEx.`androidx-appcompat`)
      }
    }
  }
}