import com.android.build.api.dsl.ApplicationBuildFeatures
import com.android.build.api.dsl.CommonExtension
import com.android.build.api.dsl.LibraryBuildFeatures
import com.google.devtools.ksp.gradle.KspExtension
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies

/**
 * 使用 ARouter
 *
 * 单独给每个模块都添加而不是直接在 build-logic 中全部添加的原因:
 * - 为了按需引入 kapt
 * - 部分 lib 模块只使用依赖，不包含注解
 *
 * @param isNeedProcessAnnotation 是否需要处理注解，对于非实现模块是不需要处理注解的，比如 api 模块
 */
fun Project.useARouter(isNeedProcessAnnotation: Boolean = !name.startsWith("api_")) {
  if (isNeedProcessAnnotation) {
    // kapt 按需引入
    apply(plugin = "com.google.devtools.ksp")
    extensions.configure<KspExtension> {
      arg("AROUTER_MODULE_NAME", project.name)
    }
    dependencies {
      "ksp"(libsEx.`arouter-compiler`)
    }
  }
  dependencies {
    "implementation"(libsEx.`arouter-api`)
  }
}

/**
 * 使用 DataBinding
 * @param isOnlyDepend 是否只依赖而不开启 DataBinding，默认开启 DataBinding
 */
fun Project.useDataBinding(isOnlyDepend: Boolean = false) {
  if (!isOnlyDepend) {
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
  dependencies {
    "implementation"(libsEx.`androidx-databinding`)
    "implementation"(libsEx.`androidx-databinding-ktx`)
  }
}

/**
 * 使用 AutoService
 * todo 感觉可以切换为我的 KtProvider https://github.com/985892345/KtProvider
 */
fun Project.dependAutoService() {
  // kapt 按需引入
  apply(plugin = "org.jetbrains.kotlin.kapt")
  dependencies {
    // 谷歌官方的一种动态加载库 https://github.com/google/auto/tree/main/service
    "compileOnly"(libsEx.autoService)
    "kapt"(libsEx.`autoService-compiler`)
  }
}

