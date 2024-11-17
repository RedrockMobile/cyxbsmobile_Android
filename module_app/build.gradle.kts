import org.gradle.kotlin.dsl.get
import utils.release.CyxbsReleaseTask
import kotlin.collections.plusAssign
import utils.config.Config

plugins {
  id("manager.application")
  alias(libs.plugins.vasdolly) // 腾讯打包插件 https://github.com/Tencent/VasDolly
}

useAutoService()

dependencies {
  // module_main 模块去依赖了其他模块，所以这里只依赖 module_main
  implementation(projects.moduleMain)

  implementation(libs.bundles.projectBase)

  implementation(libs.umeng)
  implementation(libs.umeng.asms)
  implementation(libs.umeng.push) {
    exclude(group = "com.umeng.umsdk", module = "alicloud-httpdns")
  }

  implementation(libs.okhttp)
  implementation(libs.vasdolly)
  implementation(libs.bugly.crash)
  implementation(libs.bugly.crash.native)
}

// 密钥相关
val secretGradleFile = rootDir.resolve("build-logic")
  .resolve("secret")
  .resolve("secret.gradle")
if (secretGradleFile.exists()) {
  apply(from = "$rootDir/build-logic/secret/secret.gradle")
  val ext = extensions["ext"] as ExtraPropertiesExtension
  operator fun Any?.get(key: String): Any? = (this as Map<*, *>).getOrDefault(key, null)
  android {
    signingConfigs {
      create("config") {
        // 获取保存在 secret.gradle 中的变量
        keyAlias = ext["secret"]["sign"]["RELEASE_KEY_ALIAS"] as String
        keyPassword = ext["secret"]["sign"]["RELEASE_KEY_PASSWORD"] as String
        storePassword = ext["secret"]["sign"]["RELEASE_STORE_PASSWORD"] as String
        storeFile = file("$rootDir/build-logic/secret/key-cyxbs")
      }
    }

    defaultConfig {
      // 秘钥文件
      @Suppress("UNCHECKED_CAST")
      manifestPlaceholders += (ext["secret"]["manifestPlaceholders"] as Map<String, String>)
      @Suppress("UNCHECKED_CAST")
      (ext["secret"]["buildConfigField"] as Map<String, String>).forEach { (k, v) ->
        buildConfigField("String", k, v)
      }
    }

    buildTypes {
      release {
        signingConfig = signingConfigs.getByName("config")
      }
      debug {
        signingConfig = signingConfigs.getByName("config")
      }
    }
  }
  /**
   * 注意: 如果你需要在另一个 task 中依赖打包 task，那么你大概率会出现:
   * AAPT2 aapt2-8.0.2-9289358-osx Daemon #0: Unexpected error during link, attempting to stop daemon.
   *
   * 这个是因为打包时存在多个 application 模块导致
   * 跟单模块有关，请在 ModuleDebugManagerPlugin#isAllowDebugModule 中添加你的 task name
   */
  // channel 闭包，这是腾讯的多渠道打包，输出文件在 module_app 模块的 build 文件夹下
  // ./gradlew channelRelease
  channel {
    //指定渠道文件
    channelFile = rootDir.resolve("build-logic").resolve("channel.txt")
    //多渠道包的输出目录，默认为new File(project.buildDir,"channel")
    outputDir = project.layout.buildDirectory.get().asFile.resolve("channel")
    //多渠道包的命名规则，默认为：${appName}-${versionName}-${versionCode}-${flavorName}-${buildType}-${buildTime}
    apkNameFormat = "掌上重邮-\${versionName}-\${flavorName}-\${buildType}-\${buildTime}"
    //快速模式：生成渠道包时不进行校验（速度可以提升10倍以上，默认为false）
    fastMode = false
    //buildTime的时间格式，默认格式：yyyyMMdd-HHmmss
    buildTimeDateFormat = "yyyyMMdd-HH"
    //低内存模式（仅针对V2签名，默认为false）：只把签名块、中央目录和EOCD读取到内存，不把最大头的内容块读取到内存，在手机上合成APK时，可以使用该模式
    lowMemory = false
  }
  /**
   * 发新版 task
   */
  tasks.register("cyxbsRelease", CyxbsReleaseTask::class) {
    group = "cyxbs"
    getApkFile = {
      channel.outputDir.listFiles()?.singleOrNull {
        it.name.matches(
          Regex("掌上重邮-${Config.versionName}-official-release-\\d+-\\d+\\.apk")
        )
      }
    }
    dependsOn(project.tasks.getByName("channelRelease"))
  }
}