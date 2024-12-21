plugins {
  id("manager.composeLib")
}

useARouter()

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.libBase)
      implementation(projects.libConfig)
      implementation(projects.libUtils)
      implementation(projects.libAccount.apiAccount)
      implementation(projects.moduleTodo.apiTodo)
      implementation(projects.moduleSport.apiSport)
      implementation(projects.moduleVolunteer.apiVolunteer)
      implementation(projects.cyxbsPages.electricity.api)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)
      implementation(libs.glide)
      implementation(libs.eventBus)
      implementation(libs.slideShow)
    }
  }
}

