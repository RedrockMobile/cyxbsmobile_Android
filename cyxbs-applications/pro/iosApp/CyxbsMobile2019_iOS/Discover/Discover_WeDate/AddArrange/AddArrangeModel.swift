//
//  AddArrangeModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class AddArrangeModel {
    /// 网络请求发送通知
    static func sendNotification(stuNumAry: [String], title: String, location: String, dateDic: [String: Int]) {
        let parameters: [String: Any] = [
            "stuNumList": stuNumAry,
            "title": title,
            "location": location,
            "dateJson": dateDic
        ]
        HttpTool.share().request(Discover_POST_sendNotification_API,
                                 type: .post,
                                 serializer: .JSON,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
        },
                                 failure: { task, error in
            print(error)
        })
    }
}
