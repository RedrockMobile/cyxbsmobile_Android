//
//  FinderToolsModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/3.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FinderToolsModel: Codable {
    
    var name: String
    
    var icon: String
    
    var describe: String
    
    var api_available: Bool
    
    var web_available: Bool
}

extension FinderToolsModel {
    
    init(json: JSON) {
        name = json["name"].stringValue
        icon = json["icon"].stringValue
        describe = json["describe"].stringValue
        api_available = json["api_available"].boolValue
        web_available = json["web_available"].boolValue
    }
}
