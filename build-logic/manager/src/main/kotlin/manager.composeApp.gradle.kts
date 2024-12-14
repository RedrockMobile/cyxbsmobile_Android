import org.jetbrains.compose.desktop.application.dsl.TargetFormat
import org.jetbrains.kotlin.gradle.ExperimentalWasmDsl

plugins {
  id("manager.androidApp")
  id("kmp.base")
  id("kmp.compose")
}

kotlin {
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