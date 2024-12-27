plugins {
  id("manager.library")
}

useARouter()
useRoom(rxjava = true)

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.init)
      implementation(projects.libBase)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.account.api)
      implementation(projects.cyxbsPages.course.api)
      implementation(projects.cyxbsPages.affair.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)

      // 985892345 写的桌面小组件 https://github.com/985892345/CQUPTCourseWidget
      // 目前只实现了单个透明的小组件，后续没精力维护了，让学弟重构吧
      implementation("io.github.985892345:course-widget:0.0.1-alpha06-SNAPSHOT")
    }
  }
}


