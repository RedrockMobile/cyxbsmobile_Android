plugins {
  id("manager.libraryApp")
}

useARouter()
useRoom()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.cyxbsPages.store.api)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.dialog)
  implementation(libs.ucrop)
  implementation(libs.smartRefreshLayout.header.classics)
  implementation(libs.smartRefreshLayout.footer.classics)
  implementation(libs.smartRefreshLayout)

  // PickerView https://github.com/Bigkoo/Android-PickerView
  // TODO 该库已停止更新
  implementation("com.contrarywind:Android-PickerView:4.1.9")
}


