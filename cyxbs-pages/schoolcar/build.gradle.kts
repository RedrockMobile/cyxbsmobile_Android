plugins {
  id("manager.lib")
  id("kmp.compose")
}

useKtProvider()
useDataBinding()
useRoom(rxjava = true)

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.config)
      implementation(projects.cyxbsComponents.utils)
    }
    androidMain.dependencies {
      implementation(libs.bundles.projectBase)
      implementation(libs.bundles.views)
      implementation(libs.bundles.network)

      // https://lbs.amap.com/api/android-location-sdk/guide/create-project/android-studio-create-project
      implementation("com.amap.api:3dmap:latest.integration")

      // https://github.com/koral--/android-gif-drawable
      implementation("pl.droidsonroids.gif:android-gif-drawable:1.2.25")
    }
  }
}
