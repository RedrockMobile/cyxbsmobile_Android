//
//  GroupResultItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct GroupResultItem {
    
    /// 组id
    var groupID: String
    /// 组名
    var name: String
    /// 组包含人员
    var members: [StudentResultItem]
    
    init(dictionary dic: [String: Any]) {
        groupID = dic["id"] as! String
        name = dic["name"] as! String
        
        var array: [StudentResultItem] = []
        for item in dic["members"] as! [[String: Any]] {
            array.append(StudentResultItem(dictionary: item))
        }
        members = array
    }
}
