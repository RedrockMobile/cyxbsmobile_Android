import utils.config.Config

plugins {
  id("manager.library")
}

useARouter(false) // lib_utils 模块不包含实现类，不需要处理注解

dependencies {
  implementation(projects.apiInit)
  implementation(projects.libConfig)

  implementation(libs.bundles.projectBase)
  implementation(libs.bundles.network)
  implementation(libs.glide)
  implementation(libs.rxpermissions)

  //阿里云httpdns依赖
  //https://help.aliyun.com/document_detail/434554.html?spm=a2c4g.435252.0.0.1da95979yyEzm3
  implementation(libs.alicloud.httpdns)
}

android {
  buildFeatures {
    buildConfig = true
  }
  defaultConfig {
    // 写入版本信息到 BuildConfig，其他模块可以通过调用 getAppVersionCode() 和 getAppVersionName() 方法获得
    buildConfigField("long", "VERSION_CODE", Config.versionCode.toString())
    buildConfigField("String", "VERSION_NAME", "\"${Config.versionName}\"")
  }
}