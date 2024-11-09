import org.gradle.configurationcache.extensions.capitalized

plugins {
  `kotlin-dsl`
}
java.toolchain.languageVersion.set(JavaLanguageVersion.of(libs.versions.javaTarget.get()))
tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
  kotlinOptions {
    jvmTarget = libs.versions.kotlinJvmTarget.get()
  }
}

dependencies {
  api(libs.android.gradlePlugin)
  api(libs.kotlin.gradlePlugin)
  api(libs.ksp.gradlePlugin)
}













////////////////////////////////
//
//   生成依赖 api 模块代码的脚本
//            开始
//
////////////////////////////////
fun writeDependApi(classFile: File, outputFile: File, code: (List<String>) -> String) {
  // 获取变量名
  val fieldRegex = Regex("(?<=^  {0,4}( const )?val )[a-zA-Z]+")
  val lines = classFile.readLines()
  val fields = lines.mapNotNullTo(ArrayList()) {
    fieldRegex.find(it)?.groupValues?.first()
  }
  // 寻找所有 fun Project. 行，然后去掉已经生成的 field
  out@ for (line in lines) {
    if (line.startsWith("fun Project.")) {
      // 去掉开头是空格的
      for (field in fields) {
        if (line.contains(field.capitalized())) {
          fields.remove(field)
          continue@out
        }
      }
    }
  }
  outputFile.parentFile.mkdirs()
  if (!outputFile.exists()) {
    outputFile.createNewFile()
  }
  val head = """
    // 自动生成的代码，请不要修改 !!!
    // 请查看 versions 模块下的 build.gradle.kts
  """.trimIndent()
  outputFile.writeText(head + "\n" + code.invoke(fields))
}

// 创建一个 gradle task
val taskGenerateDependApi = tasks.register("generateDependApiFunction") {
  group = "cyxbs"
  val apiDependFile = projectDir.resolve("src")
    .resolve("main")
    .resolve("kotlin")
    .resolve("api")
    .resolve("ApiDepend.kt")
  // inputs 和 outputs 用于设置 task 缓存
  // https://segmentfault.com/a/1190000039212504
  inputs.file(apiDependFile)
  // 生成的文件在模块的 build 目录下
  val outputDir = project.layout.buildDirectory.dir(
    "generated/source/dependApi/${SourceSet.MAIN_SOURCE_SET_NAME}"
  )
  outputs.dir(outputDir)
  doLast {
    // 生成 dependApi*()
    writeDependApi(
      apiDependFile,
      outputDir.get().asFile.resolve("ApiDependFunction.kt")
    ) { list ->
      val import = """
        import org.gradle.api.Project
      """.trimIndent()
      val code = list.joinToString("\n\n", "\n\n") {
        """
          fun Project.dependApi${it.capitalized()}() {
            ApiDepend.$it.dependApiOnly(this)
          }
        """.trimIndent()
      }
      import + code
    }
  }
}

val taskGenerateDependLib = tasks.register("generateDependLibFunction") {
  group = "cyxbs"
  val libDependFile = projectDir.resolve("src")
    .resolve("main")
    .resolve("kotlin")
    .resolve("lib")
    .resolve("LibDepend.kt")
  inputs.file(libDependFile)
  val outputDir = project.layout.buildDirectory.dir(
    "generated/source/dependLib/${SourceSet.MAIN_SOURCE_SET_NAME}"
  )
  outputs.dir(outputDir)
  doLast {
    // 生成 dependLib*()
    writeDependApi(
      libDependFile,
      outputDir.get().asFile.resolve("LibDependFunction.kt")
    ) { list ->
      val import = """
        import org.gradle.api.Project
        import org.gradle.kotlin.dsl.dependencies
      """.trimIndent()
      val code = list.joinToString("\n\n", "\n\n") {
        """
          fun Project.dependLib${it.capitalized()}() {
          dependencies {
            "implementation"(project(LibDepend.$it))
          }
        }
        """.trimIndent()
      }
      import + code
    }
  }
}

// 添加进编译环境和依赖环境，在编译时会自动执行 task 生成对应代码
sourceSets {
  main {
    kotlin.srcDir(taskGenerateDependApi)
    kotlin.srcDir(taskGenerateDependLib)
  }
}

////////////////////////////////
//
//   生成依赖 api 模块代码的脚本
//            结束
//
////////////////////////////////




//////////////////////////////////////////////////
//
//        获取 libs.versions.toml 中的依赖信息
//                     开始
//
//////////////////////////////////////////////////
// 将 libs 编译在项目脚本中
// src 下面是拿不到 gradle 自动生成的 libs，这里单独生成 libsEx 去获取 libs.versions.toml 中的依赖信息
val generateLibsTask = tasks.register("generateLibs") {
  group = "build-logic"
  val versionCatalogs = project.extensions.getByType(VersionCatalogsExtension::class).named("libs")
  val libsList = versionCatalogs.libraryAliases.map { it.replace(".", "-") }
  val versionList = versionCatalogs.versionAliases.map { it.replace(".", "-") }
  val pluginsList = versionCatalogs.pluginAliases.map { it.replace(".", "-") }
  val pluginIdsList = pluginsList.map { it to versionCatalogs.findPlugin(it).get().get().pluginId }
  val bundleList = versionCatalogs.bundleAliases.map { it.replace(".", "-") }
  inputs.property("libsList", libsList)
  inputs.property("versionList", versionList)
  inputs.property("pluginsList", pluginsList)
  inputs.property("bundleList", bundleList)
  // 生成的文件在模块的 build 目录下
  val outputDir = project.layout.buildDirectory.dir(
    "generated/sources/libs/${SourceSet.MAIN_SOURCE_SET_NAME}"
  )
  outputs.dir(outputDir)
  doLast {
    val file = outputDir.get().asFile.resolve("Libs.kt")
    file.parentFile.mkdirs()
    file.delete()
    file.writeText(getLibsClass(libsList, versionList, pluginsList, pluginIdsList, bundleList))
  }
}


fun getLibsClass(
  libsList: List<String>,
  versionList: List<String>,
  pluginsList: List<String>,
  pluginIdsList: List<Pair<String, String>>,
  bundleList: List<String>,
): String = """
// 由 build-logic/base/build.gradle.kts 生成

import org.gradle.api.Project
import org.gradle.api.artifacts.VersionCatalogsExtension
import org.gradle.kotlin.dsl.extra
import org.gradle.kotlin.dsl.getByType
import org.gradle.plugin.use.PluginDependency

val Project.libsEx: LibsEx
  get() = if (extra.has("libsEx")) extra.get("libsEx") as LibsEx else {
    LibsEx(this).also { extra.set("libsEx", it) }
  }

class LibsEx(val project: Project) {
  val versions = Versions()
  val plugins = Plugins()
  val bundles = Bundles()
  
  ${libsList.joinToString("\n  ") { "val `$it` get() = libsLibrary(\"$it\")" }}
  
  private val libs = project.extensions.getByType(VersionCatalogsExtension::class).named("libs")
  private fun libsLibrary(alias: String) = libs.findLibrary(alias).get()
  private fun libsBundle(alias: String) = libs.findBundle(alias).get()
  private fun libsVersion(alias: String) = libs.findVersion(alias).get()
  private fun libsPlugin(alias: String) = libs.findPlugin(alias).get()
  
  inner class Versions {
    ${versionList.joinToString("\n    ") { "val `$it` get() = libsVersion(\"$it\")" }}
  }
  
  inner class Plugins {
    ${pluginsList.joinToString("\n    ") { "val `$it` get() = libsPlugin(\"$it\")" }}
  }
  
  inner class Bundles {
    ${bundleList.joinToString("\n    ") { "val `$it` get() = libsBundle(\"$it\")" }}
  }
}

object PluginIds {
  ${pluginIdsList.joinToString("\n  ") { "val `${it.first}` = \"${it.second}\"" }}
}
""".trimIndent()

// 添加进编译环境和依赖环境，在编译时会自动执行 task 生成对应代码
sourceSets {
  main {
    kotlin.srcDir(generateLibsTask)
  }
}
//////////////////////////////////////////////////
//
//        获取 libs.versions.toml 中的依赖信息
//                     结束
//
//////////////////////////////////////////////////