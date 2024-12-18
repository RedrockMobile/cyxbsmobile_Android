plugins {
  id("manager.library")
}

useARouter()
useDataBinding()

dependencies {
  implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.libUpdate.apiUpdate)
  implementation(projects.libAccount.apiAccount)
  implementation(projects.libProtocol.apiProtocol)
  implementation(projects.moduleMine.apiMine)
  implementation(projects.cyxbsPages.login.api)
  implementation(projects.moduleStore.apiStore)
  implementation(projects.moduleCourse.apiCourse)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.androidx.work)
  implementation(libs.lPhotoPicker)
  implementation(libs.glide)
  implementation(libs.dialog)
  implementation(libs.ucrop)

  // PickerView https://github.com/Bigkoo/Android-PickerView
  // TODO 该库已停止更新
  implementation("com.contrarywind:Android-PickerView:4.1.9")
  // https://github.com/kyleduo/SwitchButton
  implementation("com.kyleduo.switchbutton:library:2.1.0")
  // TODO 应该替换为官方的 ShapeableImageView 来实现圆角图片
  implementation("de.hdodenhof:circleimageview:3.1.0")
}
