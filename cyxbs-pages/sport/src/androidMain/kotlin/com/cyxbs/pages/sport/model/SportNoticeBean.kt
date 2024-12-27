package com.cyxbs.pages.sport.model

import com.google.gson.annotations.SerializedName
import java.io.Serializable


data class NoticeItem(
    @SerializedName("title") val title: String,
    @SerializedName("content") val content: String
) : Serializable





