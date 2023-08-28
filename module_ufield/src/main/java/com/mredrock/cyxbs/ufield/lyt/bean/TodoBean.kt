package com.mredrock.cyxbs.ufield.lyt.bean

import com.google.gson.annotations.SerializedName
import java.io.Serializable

/**
 *  author : lytMoon
 *  date : 2023/8/19 20:42
 *  description :管理员待审核活动的数据接受类
 *  version ： 1.0
 */
data class TodoBean(
    @SerializedName("activity_cover_url")
    val activity_cover_url: String,
    @SerializedName("activity_create_timestamp")
    val activity_create_timestamp: Long,
    @SerializedName("activity_creator")
    val activity_creator: String,
    @SerializedName("activity_detail")
    val activity_detail: String,
    @SerializedName("activity_end_at")
    val activity_end_at: Long,
    @SerializedName("activity_id")
    val activity_id: Int,
    @SerializedName("activity_organizer")
    val activity_organizer: String,
    @SerializedName("activity_place")
    val activity_place: String,
    @SerializedName("activity_registration_type")
    val activity_registration_type: String,
    @SerializedName("activity_start_at")
    val activity_start_at: Long,
    @SerializedName("activity_title")
    val activity_title: String,
    @SerializedName("activity_type")
    val activity_type: String,
    @SerializedName("activity_watch_number")
    val activity_watch_number: Int,
    @SerializedName("phone")
    val activity_phone: String,
    @SerializedName("want_to_watch")
    val want_to_watch: Boolean
) : Serializable

