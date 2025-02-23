//
//  GroupItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/8/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct GroupItem {
    
    /// 是否置顶
    var isTop: Bool 
    /// 组id
    var groupID: Int
    /// 组名
    var name: String
    /// 组包含人员
    var members: [StudentItem]
    
    init(dictionary dic: [String: Any]) {
        isTop = dic["is_top"] as! Bool
        groupID = dic["id"] as! Int
        name = dic["name"] as! String
        
        var array: [StudentItem] = []
        for item in dic["members"] as! [[String: Any]] {
            array.append(StudentItem(dictionary: item))
        }
        members = array
    }
}
