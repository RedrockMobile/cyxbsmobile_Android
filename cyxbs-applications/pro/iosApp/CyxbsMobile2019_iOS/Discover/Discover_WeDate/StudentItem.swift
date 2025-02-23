//
//  StudentItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/8/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct StudentItem {
    
    /// 学生姓名
    var name: String
    /// 学号
    var studentID: String
    
    init(dictionary dic: [String: Any]) {
        name = dic["stu_name"] as! String
        studentID = dic["stu_num"] as! String
    }
}
