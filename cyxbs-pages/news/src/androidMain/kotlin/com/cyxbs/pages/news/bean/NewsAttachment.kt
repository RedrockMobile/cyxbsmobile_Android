package com.cyxbs.pages.news.bean

import com.google.gson.annotations.SerializedName
import java.io.Serializable

data class NewsAttachment(@SerializedName("name")
                          val name: String = "",
                          @SerializedName("id")
                          val id: String = "") : Serializable