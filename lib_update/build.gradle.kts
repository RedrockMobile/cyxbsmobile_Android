import com.mredrock.cyxbs.convention.depend.*

/*
* 这里只添加确认模块独用库，添加请之前全局搜索，是否已经依赖
* 公用库请不要添加到这里
* */
plugins {
    id("module-manager")
}

dependMaterialDialog()
dependNetwork()
dependRxPermissions()
dependRxjava()

dependencies {
    implementation(Network.`converter-gson`)
    implementation(Network.`adapter-rxjava3`)
}