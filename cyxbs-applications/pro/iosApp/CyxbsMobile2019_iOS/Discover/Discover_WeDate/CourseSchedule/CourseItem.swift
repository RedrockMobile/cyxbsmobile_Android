//
//  CourseItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct CourseItem {
    
    /// 课程编号
    var courseID: String
    /// 每节课时
    var period: Int
    /// 行课星期（数字
    var dayNum: Int
    /// 行课范围（x-x周
    var rawWeek: String
    /// 行课星期
    var day: String
    /// 课程类型（选修/必修
    var type: String
    /// 课程开始周数
    var beginWeek: Int
    /// 教室
    var classroom: String
    /// 课程结束周数
    var endWeek: Int
    /// 课程名称
    var courseName: String
    /// 教师姓名
    var teacherName: String
    /// 行课周数
    var inWeeks: IndexSet = .init()
    /// 第几节上课
    var lesson: String
    /// 第几节开始上课
    var beginLesson: Int
    /// 第几节开始上课的哈希值
    var hashLesson: Int
    
    init(dictionary dic: [String: Any]) {
        courseID = dic["course_num"] as! String
        period = dic["period"] as! Int
        dayNum = dic["hash_day"] as! Int + 1
        rawWeek = dic["rawWeek"] as! String
        day = dic["day"] as! String
        type = dic["type"] as! String
        beginWeek = dic["week_begin"] as! Int
        classroom = dic["classroom"] as! String
        endWeek = dic["week_end"] as! Int
        courseName = dic["course"] as! String
        teacherName = dic["teacher"] as! String
        lesson = dic["lesson"] as! String
        beginLesson = dic["begin_lesson"] as! Int
        hashLesson = dic["hash_lesson"] as! Int
        
        if let week = dic["week"] as? [Int] {
            week.forEach { eachWeek in
                inWeeks.insert(eachWeek)
            }
        }
    }
}
