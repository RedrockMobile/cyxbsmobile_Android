plugins {
  id("manager.lib")
}

useKtProvider()

kotlin {
  sourceSets {
    androidMain.dependencies {
      implementation(libs.rxjava)
    }
  }
}
