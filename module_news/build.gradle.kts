plugins {
  id("manager.library")
}

useARouter()

dependencies {
  implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.androidx.work)
  implementation(libs.dialog)
  implementation(libs.rxpermissions)

  // TODO 应该替换为官方的 ShapeableImageView 来实现圆角图片
  implementation("de.hdodenhof:circleimageview:3.1.0")
}
