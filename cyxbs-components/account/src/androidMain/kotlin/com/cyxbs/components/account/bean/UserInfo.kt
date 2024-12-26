package com.cyxbs.components.account.bean

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class UserInfo(
    //性别
    @SerializedName("gender")
    var gender: String? = "",

    //个人头像
    @SerializedName("photo_src")
    var photoSrc: String? = "",

    //学号
    @SerializedName("stunum")
    var stuNum: String? = "",

    //用户名字
    @SerializedName("username")
    var username: String? = "",

    //学院信息
    @SerializedName("college")
    var college: String? = "",

) : Serializable
