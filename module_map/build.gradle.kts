plugins {
  id("manager.library")
}

useARouter()
useDataBinding()
useGlide() // TODO 待清理 glide 的 kapt 后改为直接依赖 glide

dependencies {
  implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.lPhotoPicker)
  implementation(libs.glide)

  // TODO 这个是之前强神从 implementation 改成 compileOnly 的，但很奇怪的是能跑起来，应该是存在间接依赖
  compileOnly("com.davemorrissey.labs:subsampling-scale-image-view-androidx:3.10.0")
}
