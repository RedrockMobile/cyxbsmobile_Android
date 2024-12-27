plugins {
  id("manager.composeLib")
}

useARouter()
useRoom()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsPages.store.api)
    }
    androidMain.dependencies {
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
  }
}


/*
* ufield: u＝邮, field=场地
* */


