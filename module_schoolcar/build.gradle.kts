plugins {
  id("manager.library")
}

useARouter()
useDataBinding()
useRoom(rxjava = true)

dependencies {
  implementation(projects.libCommon) // TODO common 模块不再使用，新模块请依赖 base 和 utils 模块
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)

  // https://lbs.amap.com/api/android-location-sdk/guide/create-project/android-studio-create-project
  implementation("com.amap.api:3dmap:latest.integration")

  // https://github.com/koral--/android-gif-drawable
  implementation("pl.droidsonroids.gif:android-gif-drawable:1.2.25")
}
