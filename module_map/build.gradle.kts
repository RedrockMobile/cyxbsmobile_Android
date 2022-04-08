import versions.defaultNet
import versions.lPhotoPicker
import versions.threeParty

plugins {
    id("com.redrock.cyxbs")
}

dependencies {
    /*
    * 这里只添加确认模块独用库，添加请之前全局搜索，是否已经依赖
    * 公用库请不要添加到这里
    * */
    implementation("com.google.android:flexbox:2.0.1")
    compileOnly ("com.davemorrissey.labs:subsampling-scale-image-view-androidx:3.10.0")
    threeParty()
    lPhotoPicker()
}
android.buildFeatures.dataBinding = true
