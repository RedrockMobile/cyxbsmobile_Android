import ext.get
import gradle.kotlin.dsl.accessors._11b1f85c87a6b4d0c16534be4db6fa46.ext
import org.gradle.api.JavaVersion
import org.gradle.kotlin.dsl.kotlin
import versions.AGP

plugins {
    kotlin("android")
    id("com.android.library")
}

android {
    compileSdk = AGP.compileSdk

    publishing {
        singleVariant("debug")
    }
    signingConfigs {
        create("config") {
            keyAlias = project.ext["secret"]["sign"]["RELEASE_KEY_ALIAS"] as String
            keyPassword = project.ext["secret"]["sign"]["RELEASE_KEY_PASSWORD"] as String
            storePassword = project.ext["secret"]["sign"]["RELEASE_STORE_PASSWORD"] as String
            storeFile = file("$rootDir/build_logic/secret/key-cyxbs")
        }
    }
    defaultConfig {
        minSdk = AGP.mineSdk
        targetSdk = AGP.targetSdk

        testInstrumentationRunner = AGP.testInstrumentationRunner
        // 秘钥文件
        manifestPlaceholders += (project.ext["secret"]["manifestPlaceholders"] as Map<String, Any>)
        (project.ext["secret"]["buildConfigField"] as Map<String, String>).forEach { (k, v) ->
            buildConfigField("String", k, v)
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "${rootDir}/build_logic/proguard-rules.pro")

            signingConfig = signingConfigs.getByName("config")

            ndk {
                // 修改安装包的架构要记得同步修改上面的 Bugly 的 ndk 依赖
                abiFilters += listOf("arm64-v8a","armeabi-v7a")
            }
        }
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
}