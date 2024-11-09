plugins {
  id("module-manager")
}


dependLibBase()
dependLibUtils()
dependLibConfig()

dependApiCourse()

dependNetwork()
dependRxjava()

dependencies {
  implementation(libs.androidx.core.ktx)
  implementation(libs.androidx.constraintlayout)
  implementation(libs.androidx.viewpager2)
  implementation(libs.androidx.fragment.ktx)
  implementation(libs.androidx.cardview)
  api(libs.netlayout)
}