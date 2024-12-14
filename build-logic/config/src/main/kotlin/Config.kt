@file:Suppress("ObjectPropertyName")

import org.gradle.api.Project
import java.util.regex.Pattern

/**
 * ...
 * @author 985892345 (Guo Xiangrui)
 * @email 2767465918@qq.com
 * @date 2022/5/26 15:13
 */
object Config {
  // 发版有单独的 gradle task，请全局搜索 ReleaseAppTask
  const val versionCode = 88 // 线上87，开发88
  const val versionName = "6.9.1-alpha" // 线上6.9.0，开发6.9.1-alpha，自己打包 -alpha，内测 -beta

  val composeDesktopVersion: String // compose desktop 只能是 x.y.z 形式，不能带 -
    get() = versionName.substringBeforeLast("-")

  val releaseAbiFilters = listOf("arm64-v8a")
  val debugAbiFilters = listOf("arm64-v8a","x86_64")

  // 线上版本更新内容，注意缩进统一
  val updateContent = """
    1.新增体育打卡功能，空教室功能，方便邮子们的校园生活
    2.邮子清单全面升级，给邮子提供更全面的体验
    3.邮票中心升级，邮票小店库存更新
    4.重邮地图更新，新增南部校区明志苑
    5.美食咨询处更新，新增滨湖餐厅
  """.trimIndent()

  val resourcesExclude = listOf(
    "LICENSE.txt",
    "META-INF/DEPENDENCIES",
    "/META-INF/{AL2.0,LGPL2.1}",
    "META-INF/NOTICE",
    "META-INF/LICENSE",
    "META-INF/LICENSE.txt",
    "META-INF/services/javax.annotation.processing.Processor",
    "META-INF/MANIFEST.MF",
    "META-INF/NOTICE.txt",
    "META-INF/rxjava.properties",
    "**/schemas/**", // 用于取消数据库的导出文件
  )
  
  val jniExclude = listOf(
    "lib/armeabi/libAMapSDK_MAP_v6_9_4.so",
    "lib/armeabi/libsophix.so",
    "lib/armeabi/libBugly.so",
    "lib/armeabi/libpl_droidsonroids_gif.so",
    "lib/*/libRSSupport.so",
    "lib/*/librsjni.so",
    "lib/*/librsjni_androidx.so",
  )
  
  fun getApplicationId(project: Project): String {
    println("getApplicationId: ${project.path}")
    return when (project.path) {
      ":cyxbs-applications:pro" -> {
        if (project.gradle.startParameter.taskNames.any { it.contains("Release") }) {
          "com.mredrock.cyxbs"
        } else {
          // debug 状态下使用 debug 的包名，方便测试
          "com.mredrock.cyxbs.debug"
//          "com.mredrock.cyxbs" // 取消注释即可还原包名，但注意：取消注释后需要点一下右上角的大象刷新 gradle 才能生效
        }
      }
      else -> "com.mredrock.cyxbs.${project.name}"
    }
  }

  fun getBaseName(project: Project): String {
    return project.path.split(Pattern.compile("-|:")).joinToString("") {
      it.uppercase()
    }
  }
}
