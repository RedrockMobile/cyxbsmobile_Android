package com.cyxbs.pages.mine.bean


import com.google.gson.annotations.SerializedName

data class PersonData(
  @SerializedName("data")
  val `data`: Data,
  @SerializedName("info")
  val info: String,
  @SerializedName("status")
  val status: Int
) {
  data class Data(
    @SerializedName("college")
    val college: String,
    @SerializedName("gender")
    val gender: String,
    @SerializedName("stunum")
    val stunum: String,
    @SerializedName("username")
    val username: String
  )
}