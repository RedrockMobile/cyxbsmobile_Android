//
//  FinderBannerModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct FinderBannerModel: Codable {
    
    var picture_url: String
    
    var id: Int
    
    var keyword: String
    
    var picture_goto_url: String
}

extension FinderBannerModel {
    
    init(json: JSON) {
        picture_url = json["picture_url"].stringValue
        id = json["id"].intValue
        keyword = json["keyword"].stringValue
        picture_goto_url = json["picture_goto_url"].stringValue
    }
}
