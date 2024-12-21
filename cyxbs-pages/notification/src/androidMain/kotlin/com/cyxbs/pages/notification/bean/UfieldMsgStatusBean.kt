package com.cyxbs.pages.notification.bean

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class UfieldMsgStatusBean(
    @SerializedName("info")
    val info: String,
    @SerializedName("status")
    val status: Int
) : Serializable