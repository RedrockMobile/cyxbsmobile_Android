import versions.*

/*
* 这里只添加确认模块独用库，添加请之前全局搜索，是否已经依赖
* 公用库请不要添加到这里
* */
plugins {
    id("com.redrock.cyxbs")
}
dependencies {
    implementation(project(":module_main:api_main"))
    implementation(project(":lib_account:api_account"))
    implementation(project(":lib_update:api_update"))
    implementation(project(":lib_protocol:api_protocol"))
    lottie()
    eventBus()
    threeParty()
    compileOnly(`umeng-push`)
}

android.buildFeatures.dataBinding = true