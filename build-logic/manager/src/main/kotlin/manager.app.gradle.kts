import org.jetbrains.compose.desktop.application.dsl.TargetFormat
import org.jetbrains.kotlin.gradle.ExperimentalWasmDsl
import rule.ModuleNamespaceCheckRule

plugins {
  id("com.android.application")
  id("kmp.base")
  id("kmp.compose")
}

ProjectChecker.config(project) // 项目检查工具

android {
  namespace = ModuleNamespaceCheckRule.getCorrectNamespace(project)
  compileSdk = libsEx.versions.`android-compileSdk`.toInt()
  defaultConfig {
    applicationId = Config.getApplicationId(project)
    minSdk = libsEx.versions.`android-minSdk`.toInt()
    targetSdk = libsEx.versions.`android-targetSdk`.toInt()
    versionCode = Config.versionCode
    versionName = Config.versionName
    // 添加以下两句代码，这是 LPhotoPicker 需要设置的东西
    renderscriptTargetApi = libsEx.versions.`android-targetSdk`.toInt()  //版本号请与compileSdkVersion保持一致
    renderscriptSupportModeEnabled = true
  }
  buildTypes {
    release {
      isMinifyEnabled = true
      isShrinkResources = true
      proguardFiles(
        getDefaultProguardFile("proguard-android-optimize.txt"),
        rootDir.resolve("build-logic")
          .resolve("manager")
          .resolve("proguard-rules.pro")
      )

      ndk {
        abiFilters += Config.releaseAbiFilters
      }
    }
    debug {
      isMinifyEnabled = false
      proguardFiles(
        getDefaultProguardFile("proguard-android-optimize.txt"),
        rootDir.resolve("build-logic")
          .resolve("manager")
          .resolve("proguard-rules.pro")
      )

      ndk {
        abiFilters += Config.debugAbiFilters
      }
    }
  }
  compileOptions {
    val javaVersion = libsEx.versions.javaTarget
    sourceCompatibility = JavaVersion.toVersion(javaVersion)
    targetCompatibility = JavaVersion.toVersion(javaVersion)
  }
  lint {
    abortOnError = false // 编译遇到错误不退出，可以一次检查多个错误，并且已执行的 task 下次执行会直接走缓存
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
  packaging {
    jniLibs.excludes += Config.jniExclude
    resources.excludes += Config.resourcesExclude
  }
  buildFeatures {
    dataBinding = true // application 模块必须开启 databinding，因为编译期需要关联其他模块的 databinding
    buildConfig = true
  }
}

kotlin {
  if (Multiplatform.enableWasm(project)) {
    @OptIn(ExperimentalWasmDsl::class)
    wasmJs {
      browser {
        commonWebpackConfig {
          outputFileName = "${Config.getBaseName(project)}.js"
        }
      }
      binaries.executable()
    }
  }
}

if (Multiplatform.enableDesktop(project)) {
  compose.desktop {
    application {
      mainClass = "com.test.MainKt" // todo 待补充 desktop 的 main Class
      nativeDistributions {
        targetFormats(TargetFormat.Dmg, TargetFormat.Msi, TargetFormat.Deb)
        packageName = Config.getApplicationId(project)
        packageVersion = Config.composeDesktopVersion
      }
      buildTypes {
        release {
          proguard {
            isEnabled.set(true)
            configurationFiles.from(rootDir.resolve("build-logic")
              .resolve("manager")
              .resolve("proguard-rules.pro"))
          }
        }
      }
    }
  }
}

// 用于设置 iOS 项目的 project.pbxproj
// 把模版中的 iosApp 放到模块目录下，然后运行该 task 进行修改，最后新增 iOS 配置项就可以跑起来了
// 如果启动模块依赖了新的其他模块，则需要再次运行该 task
tasks.register("setIOSProjectPbxproj") {
  group = "compose ios"
  val file = projectDir.resolve("iosApp")
    .resolve("iosApp.xcodeproj")
    .resolve("project.pbxproj")
  val dependProjects = project.configurations
    .getByName("commonMainImplementation")
    .dependencies
    .asSequence()
    .filterIsInstance<ProjectDependency>()
    .map { it.dependencyProject }
    .toList()
  inputs.property("dependProjects", dependProjects.map { it.path })
  outputs.file(file)
  doFirst {
    val rootProjectPath = "\$SRCROOT" + project.path.split(":").joinToString("") { "/.." }
    val lines = file.readLines().toMutableList()
    val iterator = lines.listIterator()
    while (iterator.hasNext()) {
      val line = iterator.next()
      if (line.contains("shellScript = ")) {
        if (line.contains("\$SRCROOT")) {
          iterator.set(
            line.substringBeforeLast("\$SRCROOT") +
                "${rootProjectPath}\\\"\\n./gradlew ${project.path}:embedAndSignAppleFrameworkForXcode\\n\";"
          )
        }
      }
      if (line.contains("FRAMEWORK_SEARCH_PATHS")) {
        while (iterator.hasNext() && !iterator.next().contains(";")) {
          iterator.remove()
        }
        iterator.previous()
        val space = line.substringBefore("FRAMEWORK_SEARCH_PATHS") + "    "
        iterator.add("$space\"\$(inherited)\",")
        (dependProjects + project).map {
          space + "\"" + rootProjectPath + it.path.replace(":", "/") + "/build/xcode-frameworks/\$(CONFIGURATION)/\$(SDK_NAME)\","
        }.forEach {
          iterator.add(it)
        }
      }
    }
    file.writeText(lines.joinToString("\n"))
  }
}