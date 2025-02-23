//
//  NormalStudentItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct NormalStudentItem {
    
    /// 学生姓名
    var name: String
    /// 学号
    var studentID: String
    
    init(dictionary dic: [String: Any]) {
        name = dic["real_name"] as! String
        studentID = dic["stu_num"] as! String
    }
}
