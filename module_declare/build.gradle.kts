plugins {
    id("module-debug")
}


dependLibBase()
dependLibUtils()
dependLibConfig()
dependApiStore()

dependRxjava()
dependNetwork()
dependCoroutinesRx3()
dependMaterialDialog()
useDataBinding()
useARouter()
dependencies {
    implementation(libs.androidx.appcompat)
    implementation(libs.androidx.constraintlayout)
    implementation(libs.material)
}