package com.cyxbs.components.account.bean

/**
 * author : QTwawa
 * date : 2024/10/21 15:56
 * description :用来解析登录错误返回的信息
 */
data class ErrorMsg(
    val data: String,
    val status: Int,
    val errcode: Int,
    val errmessage: String
)