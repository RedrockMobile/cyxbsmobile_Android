package com.cyxbs.pages.ufield.helper

import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

fun formatNumberToTime(second: Long): String {
    return SimpleDateFormat("yyyy年MM月dd日", Locale.getDefault()).format(
        Date(second * 1000)
    )
}

fun timeFormat(second: Long): String {
    return SimpleDateFormat("yyyy.MM.dd", Locale.getDefault()).format(
        Date(second * 1000)
    )
}
