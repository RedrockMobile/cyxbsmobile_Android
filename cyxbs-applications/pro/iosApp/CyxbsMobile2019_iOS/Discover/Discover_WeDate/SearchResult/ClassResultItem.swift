//
//  ClassResultItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct ClassResultItem {
    
    /// 班级id
    var classID: String
    /// 班级包含人员
    var members: [StudentResultItem]
    
    init(dictionary dic: [String: Any]) {
        classID = dic["id"] as! String
        
        var array: [StudentResultItem] = []
        for item in dic["members"] as! [[String: Any]] {
            array.append(StudentResultItem(dictionary: item))
        }
        members = array
    }
}
