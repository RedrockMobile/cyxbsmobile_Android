plugins {
  id("manager.library")
}

useARouter()
useRoom()

dependencies {
  implementation(projects.libBase)
  implementation(projects.libConfig)
  implementation(projects.libUtils)
  implementation(projects.moduleTodo.apiTodo)
  implementation(projects.cyxbsPages.store.api)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.views)
  implementation(libs.bundles.network)
  implementation(libs.wheelPicker)
}