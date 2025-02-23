//
//  ArrangeMessageModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArrangeMessageModel {
    
    /// 消息信息数组
    var messageAry: [ArrangeMessageItem] = []
    
    static func getReceivedMessage(success: ((_ groupModel: ArrangeMessageModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let parameters = ["typ": "received"]
        HttpTool.share().request(Discover_GET_arrangeMessage_API,
                                 type: .get,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            let messageModel = ArrangeMessageModel()
            let json = JSON(object!)
            
            if let messages = json["data"].arrayObject as? [[String: Any]]  {
                for dic in messages {
                    let message = ArrangeMessageItem(dictionary: dic)
                    messageModel.messageAry.append(message)
                    
                    if let hasCancel = dic["hasCancel"] as? Bool,
                       hasCancel,
                       let content = dic["content"] as? String,
                       !content.contains("已取消") {
                        var addDic = dic
                        addDic["content"] = dic["content"] as! String + "的行程已取消"
                        messageModel.messageAry.append(ArrangeMessageItem(dictionary: addDic))
                    }
                }
            }
            
            success?(messageModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
    
    static func getSentMessage(success: ((_ groupModel: ArrangeMessageModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let parameters = ["typ": "sent"]
        HttpTool.share().request(Discover_GET_arrangeMessage_API,
                                 type: .get,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            let messageModel = ArrangeMessageModel()
            let json = JSON(object!)

            if let messages = json["data"].arrayObject as? [[String: Any]]  {
                for dic in messages {
                    let message = ArrangeMessageItem(dictionary: dic)
                    messageModel.messageAry.append(message)
                }
            }
            
            success?(messageModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
}
