//
//  UpdatePersonModelTool.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2024/3/5.
//  Copyright © 2024 Redrock. All rights reserved.
//

import Foundation

class UpdatePersonModelTool: NSObject {
    
    @objc static var shared = UpdatePersonModelTool()
    
    @objc func update() {
        HttpManager.shared.magipoke_Person_Search().ry_JSON { response in
            if case .success(let model) = response, model["status"].stringValue == "10000" {
                let person = PersonModel(json: model["data"])
                UserModel.default.person = person
            }
        }
    }
}
