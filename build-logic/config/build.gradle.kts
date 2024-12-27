plugins {
  `kotlin-dsl`
}

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
  val libsList = versionCatalogs.libraryAliases.map {
    it.replace(".", "-") to versionCatalogs.findLibrary(it).get().get().toString()
  }
  val versionList = versionCatalogs.versionAliases.map {
    it.replace(".", "-") to versionCatalogs.findVersion(it).get().toString()
  }
  val pluginsList = versionCatalogs.pluginAliases.map {
    it.replace(".", "-") to versionCatalogs.findPlugin(it).get().get().toString()
  }
  val bundleList = versionCatalogs.bundleAliases.map {
    it.replace(".", "-") to versionCatalogs.findBundle(it).get().get().map { it.toString() }
  }
  val libClassText = getLibsClass(libsList, versionList, pluginsList, bundleList)
  inputs.property("libClassText", libClassText)
  // 生成的文件在模块的 build 目录下
  val outputDir = project.layout.buildDirectory.dir(
    "generated/sources/libs/${SourceSet.MAIN_SOURCE_SET_NAME}"
  )
  outputs.dir(outputDir)
  doLast {
    val file = outputDir.get().asFile.resolve("Libs.kt")
    file.parentFile.mkdirs()
    file.delete()
    file.writeText(libClassText)
  }
}

fun getLibsClass(
  libsList: List<Pair<String, String>>,
  versionList: List<Pair<String, String>>,
  pluginsList: List<Pair<String, String>>,
  bundleList: List<Pair<String, List<String>>>,
): String = """
/**
 * 获取 libs.versions.toml 中的依赖信息
 *
 * 由 build-logic/config/build.gradle.kts 生成
 */
val libsEx = LibsEx()

class LibsEx {
  val versions = Versions()
  val plugins = Plugins()
  val bundles = Bundles()
  
  ${libsList.joinToString("\n  ") { "val ${it.first.safe()} = \"${it.second}\"" }}
  
  inner class Versions {
    ${versionList.joinToString("\n    ") { "val ${it.first.safe()} = \"${it.second}\"" }}
  }
  
  inner class Plugins {
    ${pluginsList.joinToString("\n    ") { "val ${it.first.safe()} = \"${it.second}\"" }}
  }
  
  inner class Bundles {
    ${bundleList.joinToString("\n    ") { "val ${it.first.safe()} = listOf(${it.second.joinToString(",\n      ") { "\"$it\"" }})"}}
  }
}

""".trimIndent()

fun String.safe(): String = if (this.contains("-")) "`$this`" else this

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