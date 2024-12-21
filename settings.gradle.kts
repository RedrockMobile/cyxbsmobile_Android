@file:Suppress("UnstableApiUsage")

// 开启模块的简化依赖方式，例如：module.course.api.course
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")

/*
* 这里每次新建模块都会 include，把它们删掉，因为已经默认 include 了
* */

pluginManagement {
  includeBuild("build-logic")
  repositories {
    gradlePluginPortal()
    mavenCentral()
    google()
    maven("https://maven.pkg.jetbrains.space/public/p/compose/dev") // compose multiplatform
    maven("https://jitpack.io")
    jcenter() // 部分依赖需要
  }
}
dependencyResolutionManagement {
  repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
  repositories {
    maven("$rootDir/build/maven") // 本地模块缓存文件夹
    google()
    mavenCentral() // 优先 MavenCentral，一是：github CI 下不了 aliyun 依赖；二是：开 VPN 访问 aliyun 反而变慢了
    maven("https://maven.pkg.jetbrains.space/public/p/compose/dev")
    maven("https://jitpack.io")
    jcenter() // 部分依赖需要
    // mavenCentral 快照仓库
    maven("https://s01.oss.sonatype.org/content/repositories/snapshots/") // compose multiplatform
    maven("https://maven.aliyun.com/repository/public")
    maven("https://maven.aliyun.com/repository/google")
    mavenLocal() // maven 默认的本地依赖位置：用户名/.m2/repository 中
  }
}

// 测试使用，排除掉不需要的模块，记得还原！！！
val excludeList = setOf<String>(
  "module_qa", // qa 模块因合规问题下线，新的代替将上线，所以排除 qa
  "module_main",
  "module_login",
  "module_affair",
  "module_calendar",
  "module_declare",
  "module_dialog",
  "module_discover",
  "module_map",
  "module_electricity",
  "module_emptyroom",
  "module_food",
  "module_grades",
  "module_mine",
  "module_news",
)

//对文件夹进行遍历，深度为2
rootDir.walk()
  .maxDepth(2)
  .asSequence()
  .filter {
    //过滤掉干扰文件夹
    val isDirectory = it.isDirectory
    val isSubModule = it.resolve("build.gradle").exists()
      || it.resolve("build.gradle.kts").exists()
    val isIndependentProject = it.resolve("settings.gradle").exists()
      || it.resolve("settings.gradle.kts").exists()
    isDirectory && isSubModule && !isIndependentProject
  }
  .filter {
    //对module进行过滤
    "(api_.+)|(module_.+)|(lib_.+)".toRegex().matches(it.name)
      && it.name !in excludeList
      && it.parentFile.name !in excludeList // 如果父模块被忽略，则子模块同步忽略
  }
  .map {
    //将file映射到相对路径
    val parentFile = it.parentFile
    if (parentFile.path == rootDir.path) {
      ":${it.name}"
    } else {
      ":${parentFile.name}:${it.name}"
    }
  }
  .forEach {
    //进行include
    include(it)
  }
/**
 * 每次新建模块会自动添加 include()，请删除掉，因为上面会自动读取
 */
include("cyxbs-applications:pro")
include("cyxbs-applications:test")
include("cyxbs-pages:home")
include("cyxbs-pages:login")
include("cyxbs-pages:login:api")
include("cyxbs-pages:affair")
include("cyxbs-pages:affair:api")
include("cyxbs-pages:declare")
include("cyxbs-pages:discover")
include("cyxbs-pages:map")
include("cyxbs-pages:electricity")
include("cyxbs-pages:electricity:api")
include("cyxbs-pages:emptyroom")
include("cyxbs-pages:food")
include("cyxbs-pages:grades")
include("cyxbs-pages:mine")
include("cyxbs-pages:mine:api")
include("cyxbs-pages:news")





// 如果 build 窗口乱码，去 顶部栏 - Help - Edit Custom VM Options 里面添加 -Dfile.encoding=UTF-8，然后重启 AS
// 制作网址：http://patorjk.com/software/taag/
val redrock = """
  
   _______                   __  _______                       __
  |       \                 |  \|       \                     |  \      
  | ▓▓▓▓▓▓▓\  ______    ____| ▓▓| ▓▓▓▓▓▓▓\  ______    _______ | ▓▓   __ 
  | ▓▓__| ▓▓ /      \  /      ▓▓| ▓▓__| ▓▓ /      \  /       \| ▓▓  /  \
  | ▓▓    ▓▓|  ▓▓▓▓▓▓\|  ▓▓▓▓▓▓▓| ▓▓    ▓▓|  ▓▓▓▓▓▓\|  ▓▓▓▓▓▓▓| ▓▓_/  ▓▓
  | ▓▓▓▓▓▓▓\| ▓▓    ▓▓| ▓▓  | ▓▓| ▓▓▓▓▓▓▓\| ▓▓  | ▓▓| ▓▓      | ▓▓   ▓▓ 
  | ▓▓  | ▓▓| ▓▓▓▓▓▓▓▓| ▓▓__| ▓▓| ▓▓  | ▓▓| ▓▓__/ ▓▓| ▓▓_____ | ▓▓▓▓▓▓\ 
  | ▓▓  | ▓▓ \▓▓     \ \▓▓    ▓▓| ▓▓  | ▓▓ \▓▓    ▓▓ \▓▓     \| ▓▓  \▓▓\
   \▓▓   \▓▓  \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓ \▓▓   \▓▓  \▓▓▓▓▓▓   \▓▓▓▓▓▓▓ \▓▓   \▓▓

""".trimIndent()
println(redrock)
