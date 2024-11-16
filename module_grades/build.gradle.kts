plugins {
  id("manager.library")
}

//dependLibCommon() // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块

useARouter()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libAccount.apiAccount)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.glide)
  implementation(libs.lottie)

  // TODO 使用 官方的 ShapeableImageView 来实现圆角图片
  implementation("de.hdodenhof:circleimageview:3.1.0")
}
