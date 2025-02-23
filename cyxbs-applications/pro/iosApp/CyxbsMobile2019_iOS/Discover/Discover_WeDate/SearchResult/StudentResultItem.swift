//
//  StudentResultItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct StudentResultItem {
    
    /// 学生姓名
    var name: String
    /// 学号
    var studentID: String
    /// 学院
    var depart: String
    /// 专业名称
    var major: String
    /// 班级号
    var classID: String
    /// 入学时间
    var grade: String
    /// 性别
    var gender: String
    
    init(dictionary dic: [String: Any]) {
        name = dic["name"] as? String ?? ""
        studentID = dic["stunum"] as? String ?? ""
        depart = dic["depart"] as? String ?? ""
        major = dic["major"] as? String ?? ""
        classID = dic["classnum"] as? String ?? ""
        grade = String(dic["grade"] as? Int ?? 0)
        gender = dic["gender"] as? String ?? ""
    }
}

extension StudentResultItem: Equatable {
    static func ==(lhs: StudentResultItem, rhs: StudentResultItem) -> Bool {
        return lhs.studentID == rhs.studentID
    }
}
