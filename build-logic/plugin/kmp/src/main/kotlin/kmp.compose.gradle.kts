import com.android.build.gradle.BaseExtension

plugins {
  id("org.jetbrains.kotlin.plugin.compose")
  id("org.jetbrains.compose")
  id("kmp.base")
}

kotlin {
  sourceSets {
    val desktopMain by getting

    commonMain.dependencies {
      implementation(compose.runtime)
      implementation(compose.foundation)
      implementation(compose.material)
      implementation(compose.material3)
      implementation(compose.ui)
      implementation(compose.components.resources)
      implementation(compose.components.uiToolingPreview)
      implementation(compose.materialIconsExtended)
      implementation(libsEx.`compose-navigation`)
      implementation(libsEx.`compose-lifecycle`)
    }
    desktopMain.dependencies {
      implementation(compose.desktop.currentOs)
    }
    androidMain.dependencies {
      implementation(compose.preview)
      implementation(libsEx.`androidx-activity-compose`)
    }
  }
}

plugins.withId("com.android.base") {
  configure<BaseExtension> {
    buildFeatures.compose = true
  }
  dependencies {
    add("debugImplementation", compose.uiTooling)
  }
}

composeCompiler {
  // https://developer.android.com/jetpack/compose/performance/stability/diagnose#compose-compiler
  reportsDestination.set(
    layout.buildDirectory.get().asFile.resolve("compose_compiler")
  )

  // 对 Compose 配置外部类的稳定性
  // 只允许配置已有第三方库里面的类，如果是自己的类请打上 @Stable 注解
  // 配置规则可以查看 https://android-review.googlesource.com/c/platform/frameworks/support/+/2668595
  // 开启强跳过模式后可以不再设置外部类稳定性
//  stabilityConfigurationFile.set(
//    rootDir.resolve("config").resolve("compose-stability-config.txt")
//  )

  featureFlags.set(
    listOf(
      // 强跳过模式
      // https://developer.android.com/develop/ui/compose/performance/stability/strongskipping?hl=zh-cn
//      org.jetbrains.kotlin.compose.compiler.gradle.ComposeFeatureFlag.OptimizeNonSkippingGroups,
    )
  )
}
