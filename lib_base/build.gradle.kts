plugins {
  id("manager.library")
}

useDataBinding(true) // lib_base 模块只依赖 DataBinding 但不开启 DataBinding
useARouter(false) // lib_base 模块不包含实现类，不需要处理注解

dependencies {
  implementation(projects.libUtils)
  implementation(projects.libConfig)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.moduleLogin.apiLogin)
  implementation(projects.apiInit)
  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
}