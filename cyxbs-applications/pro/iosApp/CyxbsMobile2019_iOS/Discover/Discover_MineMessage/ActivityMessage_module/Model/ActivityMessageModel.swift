//
//  ActivityMessageModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/11/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc class ActivityMessageModel: NSObject {
    var activityMessages: [ActivityMessage] = [] {
        didSet {
            needDot = false
            for message in activityMessages {
                if !message.clicked {
                    needDot = true
                }
            }
        }
    }
    @objc var needDot : Bool = false
    
    @objc func requestActivityMessages(lower_id: NSNumber?, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        HttpManager.shared.magipoke_ufield_message_list(lower_id: lower_id?.intValue).ry_JSON { response in
            switch response {
            case .success(let jsonData):
                // 成功的处理逻辑
                let activityMessageResponse = ActivityMessageResponse(from: jsonData)
                if(activityMessageResponse.status == 10000) {
                    self.activityMessages = activityMessageResponse.data
                    success()
                } else {
                    failure(nil)
                }
            case .failure(let error):
                // 失败的处理逻辑
                print("请求失败，错误：\(error)")
                failure(error)
            }
        }
        print(activityMessages.count)
    }
}

struct ActivityMessageResponse: Codable {
    let data: [ActivityMessage]
    let info: String
    let status: Int
    
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = json["data"].arrayValue.map { ActivityMessage(from: $0) }
    }    
}

struct ActivityResponse: Codable {
    let data: Activity
    let info: String
    let status: Int
    
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = Activity(from: json["data"])
    }
}

struct ActivityMessage: Codable {
    let messageId: Int
    let messageType: String
    let rejectReason: String?
    let examineTimestamp: Int?
    let wantToWatchTimestamp: Int?
    let clicked: Bool
    let activityInfo: ActivityInfo

    enum CodingKeys: String, CodingKey {
        case messageId = "message_id"
        case messageType = "message_type"
        case rejectReason = "reject_reason"
        case examineTimestamp = "examine_timestamp"
        case wantToWatchTimestamp = "activity_want_to_watch_timestamp"
        case clicked
        case activityInfo = "activity_info"
    }
    
    init(from json: JSON) {
        messageId = json["message_id"].intValue
        messageType = json["message_type"].stringValue
        rejectReason = json["reject_reason"].stringValue
        examineTimestamp = json["examine_timestamp"].intValue
        wantToWatchTimestamp = json["activity_want_to_watch_timestamp"].intValue
        clicked = json["clicked"].boolValue
        activityInfo = ActivityInfo(from: json["activity_info"])
    }
}

struct ActivityInfo: Codable {

    var activityId: Int
    var activityTitle: String
    var activityPlace: String
    var activityType: String
    var activityDetail: String
    var activityCreateTimestamp: Int
    var activityStartAt: Int
    var activityEndAt: Int
    var activityOrganizer: String
    var activityRegistrationType: String
}

extension ActivityInfo {
    init(from json: JSON) {
        activityTitle = json["activity_title"].stringValue
        activityType = json["activity_type"].stringValue
        activityId = json["activity_id"].intValue
        activityCreateTimestamp = json["created_at"].intValue
        activityDetail = json["activity_content"].stringValue
        activityStartAt = json["start_at"].intValue
        activityEndAt = json["end_at"].intValue
        activityOrganizer = json["organizer"].stringValue
        activityPlace = json["activity_place"].stringValue
        activityRegistrationType = json["registeration_type"].stringValue
    }
}
