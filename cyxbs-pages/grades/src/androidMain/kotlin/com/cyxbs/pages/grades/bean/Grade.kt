package com.cyxbs.pages.grades.bean

import java.io.Serializable

data class Grade(
        val course: String,
        val grade: String,
        val property: String,
        val status: String,
        val student: String,
        val term: String
):Serializable