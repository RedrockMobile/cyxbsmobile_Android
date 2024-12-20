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
      implementation(libsEx.`kmp-uri`)
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
      }
    }
  }
}