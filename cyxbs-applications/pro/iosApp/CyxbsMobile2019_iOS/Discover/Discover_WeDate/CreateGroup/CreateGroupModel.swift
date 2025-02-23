//
//  CreateGroupModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/8/29.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class CreateGroupModel {
    
    var isRepeat = Bool()
    
    static func requestWith(name: String, studentID: [String], success: ((_ createGroupModel: CreateGroupModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let studentIDStr = studentID.joined(separator: ",")
        let parameters = ["name": name, "stu_nums": studentIDStr]
        HttpTool.share().request(Discover_POST_createGroup_API,
                                 type: .post,
                                 serializer: .JSON,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            let createGroupModel = CreateGroupModel()
            if let object = object as? [String: Any],
               let data = object["data"] as? String {
                if data == "exist" {
                    createGroupModel.isRepeat = true
                } else {
                    createGroupModel.isRepeat = false
                }
            }
            
            success?(createGroupModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
}
