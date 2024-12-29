plugins {
  id("manager.lib")
  id("kmp.compose")
}

useKtProvider(false) // base 模块不包含实现类，不需要处理注解
useDataBinding(false) // base 模块只依赖 DataBinding 但不开启 DataBinding

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.init)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.account.api)
      implementation(projects.cyxbsPages.login.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.photoView)
      implementation(libs.slideShow)
      implementation(libs.glide)
    }
  }
}
