import com.android.build.api.dsl.ApplicationBuildFeatures
import com.android.build.api.dsl.CommonExtension
import com.android.build.api.dsl.LibraryBuildFeatures
import com.g985892345.provider.plugin.gradle.extensions.KtProviderExtensions
import com.google.devtools.ksp.gradle.KspExtension
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension


/**
 * 使用 KtProvider
 * 985892345 的 KMP 多平台服务提供框架
 * 单独给每个模块都添加而不是直接在 build-logic 中全部添加的原因:
 * - 为了按需引入 ksp
 * - 部分 lib 模块只使用依赖，不包含注解，只需要依赖
 */
fun Project.useKtProvider(isNeedKsp: Boolean = !name.startsWith("api")) {
  if (isNeedKsp) {
    // kapt 按需引入
    apply(plugin = "com.google.devtools.ksp")
    apply(plugin = libsEx.plugins.ktProvider)
    val ktProvider = extensions.getByName("ktProvider") as KtProviderExtensions
    kspMultiplatform(ktProvider.ksp)
  }
  extensions.configure<KotlinMultiplatformExtension> {
    sourceSets.commonMain.dependencies {
      implementation(libsEx.`kmp-ktProvider-api`)
    }
  }
}

/**
 * 使用 DataBinding
 * @param isNeedKapt 是否只依赖而不开启 DataBinding，默认开启 DataBinding
 */
@Deprecated("不再建议使用 DataBinding，因为强依赖了 kapt，官方也未提供 ksp 支持。使用 Int.view() 或者 findViewById() 代替")
fun Project.useDataBinding(isNeedKapt: Boolean = !name.startsWith("api")) {
  if (!Multiplatform.runAndroid(project)) return // 其他平台不引入 kapt 插件
  if (isNeedKapt) {
    // kapt 按需引入
    apply(plugin = "org.jetbrains.kotlin.kapt")
    extensions.configure(CommonExtension::class.java) {
      buildFeatures {
        when (this) {
          is LibraryBuildFeatures -> dataBinding = true // com.android.library 插件的配置
          is ApplicationBuildFeatures -> dataBinding = true // com.android.application 插件的配置
        }
      }
    }
  }
  extensions.configure<KotlinMultiplatformExtension> {
    sourceSets.androidMain.dependencies {
      implementation(libsEx.`androidx-databinding`)
      implementation(libsEx.`androidx-databinding-ktx`)
    }
  }
}

/**
 * 使用 Room，已默认支持与 Kt 协程一起使用
 * @param rxjava 依赖 room-rxjava
 * @param paging 依赖 room-paging
 */
fun Project.useRoom(
  rxjava: Boolean = false,
  paging: Boolean = false,
) {
  // ksp 按需引入
  apply(plugin = "com.google.devtools.ksp")
  extensions.configure<KspExtension> {
    arg("room.schemaLocation", "${project.projectDir}/schemas") // room 的架构导出目录
    // https://developer.android.com/jetpack/androidx/releases/room#compiler-options
    // 启用 Gradle 增量注释处理器
    arg("room.incremental", "true")
  }
  extensions.configure<KotlinMultiplatformExtension> {
    sourceSets.androidMain.dependencies {
      implementation(libsEx.`androidx-room`)
      implementation(libsEx.`androidx-room-ktx`)
      if (rxjava) {
        implementation(libsEx.`androidx-room-rxjava`)
      }
      if (paging) {
        implementation(libsEx.`androidx-room-paging`)
      }
    }
  }
  dependencies {
    "kspAndroid"(libsEx.`androidx-room-compiler`)
  }
}

private fun Project.kspMultiplatform(dependencyNotation: Any) {
  dependencies {
    "kspAndroid"(dependencyNotation)
    if (Multiplatform.enableIOS(project)) {
      "kspIosX64"(dependencyNotation)
      "kspIosArm64"(dependencyNotation)
      "kspIosSimulatorArm64"(dependencyNotation)
    }
    if (Multiplatform.enableWasm(project)) {
      "kspWasmJs"(dependencyNotation)
    }
    if (Multiplatform.enableDesktop(project)) {
      "kspDesktop"(dependencyNotation)
    }
  }
}
