plugins {
  id("module-manager")
}




dependApiAccount()
dependApiInit()

dependRxjava()
dependMaterialDialog() // 因为要设置 MaterialDialog 主题所以依赖

dependAutoService()

dependencies {
  implementation(libs.androidx.appcompat)
  implementation(libs.androidx.constraintlayout)
  implementation(libs.material)
}

useARouter()
