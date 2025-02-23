//
//  ConfidentialityQuestionModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ConfidentialityQuestionModel: Codable {
    
    var id: Int
    
    var content: String
}

extension ConfidentialityQuestionModel {
    
    init(json: JSON) {
        id = json["id"].intValue
        content = json["content"].stringValue
    }
}
