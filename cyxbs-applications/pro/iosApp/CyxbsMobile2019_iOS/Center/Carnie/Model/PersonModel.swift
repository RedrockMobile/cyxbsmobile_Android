//
//  PersonModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PersonModel: Codable {
    
    var uid: Int
    
    var redid: String
    
    var stunum: String
    
    var photo_src: String
    
    var nickname: String
    
    var introduction: String
    
    var phone: String
    
    var qq: String
    
    var gender: String
    
    var birthday: String
    
    var background_url: String
    
//    var identityies: Any Codable
    
    var constellation: String
    
    var grade: String
    
    var college: String
    
    var is_self: Bool
    
    var isFocus: Bool
    
    var isBefocused: Bool
    
    var photo_thumbnail_src: String
    
    var username: String
}

extension PersonModel {
    
    init(json: JSON) {
        uid = json["uid"].intValue
        redid = json["redid"].stringValue
        stunum = json["stunum"].stringValue
        photo_src = json["photo_src"].stringValue
        nickname = json["nickname"].stringValue
        introduction = json["introduction"].stringValue
        phone = json["phone"].stringValue
        qq = json["qq"].stringValue
        gender = json["gender"].stringValue
        birthday = json["birthday"].stringValue
        background_url = json["background_url"].stringValue
        constellation = json["constellation"].stringValue
        grade = json["grade"].stringValue
        college = json["college"].stringValue
        is_self = json["is_self"].boolValue
        isFocus = json["isFocus"].boolValue
        isBefocused = json["isBefocused"].boolValue
        photo_thumbnail_src = json["photo_thumbnail_src"].stringValue
        username = json["username"].stringValue
    }
}
