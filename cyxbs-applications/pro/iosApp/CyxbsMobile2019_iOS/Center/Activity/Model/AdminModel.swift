//
//  AdminModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AdminResponseData: Codable {
    var data: AdminDataItem?
    var info: String
    var status: Int
}

extension AdminResponseData {
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = AdminDataItem(from: json["data"])
    }
}

struct AdminDataItem: Codable {
    var admin: Bool?
}

extension AdminDataItem {
    init(from json: JSON) {
        admin = json["admin"].bool
    }
}

