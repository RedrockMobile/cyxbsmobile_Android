plugins {
  id("manager.lib")
  id("kmp.compose")
}

useKtProvider()
useRoom(rxjava = true)

kotlin {
  sourceSets {
    commonMain.dependencies {
      implementation(projects.cyxbsComponents.base)
      implementation(projects.cyxbsComponents.utils)
      implementation(projects.cyxbsComponents.config)
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
