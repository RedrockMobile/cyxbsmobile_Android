
plugins {
    `kotlin-dsl`
}

gradlePlugin {
    plugins {
        create("com.mredrock.team.cache"){
            implementationClass = "PublishPlugin"
            id = "com.mredrock.team.cache"
        }
    }
}

dependencies {
    implementation(libs.android.gradlePlugin)
    implementation(libs.kotlin.gradlePlugin)
}