//
//  ActivityModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

class ActivitiesModel {
    
    var activities: [Activity] = []

    ///用于请求活动布告栏的活动
    func requestNoticeboardActivities(activityType: String?, success: @escaping ([Activity]) -> Void, failure: @escaping (Error) -> Void) {
        activities = []
        HttpManager.shared.magipoke_ufield_activity_list_all(activity_type: activityType).ry_JSON { response in
            switch response {
            case .success(let jsonData):
                // 成功的处理逻辑
                let allActivityResponse = AllActivityResponse(from: jsonData)
                self.activities = allActivityResponse.data.ongoing + allActivityResponse.data.ended
                success(self.activities)
            case .failure(let error):
                // 失败的处理逻辑
                print("请求失败，错误：\(error)")
                failure(error)
            }
        }
    }
    
    ///用于请求排行榜的活动
    func requestHitActivity(success: @escaping ([Activity]) -> Void, failure: @escaping (Error) -> Void) {
        activities = []
        HttpManager.shared.magipoke_ufield_activity_search(activity_type: "all", activity_num: 50, order_by: "watch").ry_JSON { response in
            switch response {
            case .success(let jsonData):
                let hitActivityResponse = SearchActivityResponse(from: jsonData)
                let activities = hitActivityResponse.data
                self.activities = activities
                success(activities)
                break
            case .failure(let error):
                print(error)
                failure(error)
                break
            }
        }
    }
    
    ///用于请求搜索活动
    func requestSearchActivity(keyword: String, activityType: String, success: @escaping ([Activity]) -> Void, failure: @escaping (Error) -> Void) {
        activities = []
        HttpManager.shared.magipoke_ufield_activity_search(activity_type: activityType, activity_num: 50, order_by: "start_timestamp_but_ongoing_first", contain_keyword: keyword).ry_JSON { response in
            switch response {
            case .success(let jsonData):
                let searchResponse = SearchActivityResponse(from: jsonData)
                let activities = searchResponse.data
                self.activities = activities
                success(activities)
                break
            case .failure(let error):
                print(error)
                failure(error)
                break
            }
        }
    }
}


struct Activity: Codable {
    
    var activityTitle: String
    var activityType: String
    var activityId: Int
    var activityCreateTimestamp: Int
    var activityDetail: String
    var activityStartAt: Int
    var activityEndAt: Int
    var activityWatchNumber: Int
    var activityOrganizer: String
    var activityCreator: String
    var activityPlace: String
    var activityRegistrationType: String
    var activityCoverURL: String
    var wantToWatch: Bool?
    var ended: Bool?
    var state: String?
    var phone: String?
    var isAdded: Bool? // 是否添加为待办

    private enum CodingKeys: String, CodingKey {
        case activityTitle = "activity_title"
        case activityType = "activity_type"
        case activityId = "activity_id"
        case activityCreateTimestamp = "activity_create_timestamp"
        case activityDetail = "activity_detail"
        case activityStartAt = "activity_start_at"
        case activityEndAt = "activity_end_at"
        case activityWatchNumber = "activity_watch_number"
        case activityOrganizer = "activity_organizer"
        case activityCreator = "activity_creator"
        case activityPlace = "activity_place"
        case activityRegistrationType = "activity_registration_type"
        case activityCoverURL = "activity_cover_url"
        case wantToWatch = "want_to_watch"
        case ended = "ended"
        case state = "activity_state"
        case phone = "phone"
        case isAdded = "is_add"
    }
}

extension Activity {
    init(from json: JSON) {
        activityTitle = json["activity_title"].stringValue
        activityType = json["activity_type"].stringValue
        activityId = json["activity_id"].intValue
        activityCreateTimestamp = json["activity_create_timestamp"].intValue
        activityDetail = json["activity_detail"].stringValue
        activityStartAt = json["activity_start_at"].intValue
        activityEndAt = json["activity_end_at"].intValue
        activityWatchNumber = json["activity_watch_number"].intValue
        activityOrganizer = json["activity_organizer"].stringValue
        activityCreator = json["activity_creator"].stringValue
        activityPlace = json["activity_place"].stringValue
        activityRegistrationType = json["activity_registration_type"].stringValue
        activityCoverURL = json["activity_cover_url"].stringValue
        wantToWatch = json["want_to_watch"].bool
        ended = json["ended"].bool
        state = json["activity_state"].stringValue
        isAdded = json["is_add"].boolValue
        phone = json["phone"].stringValue
    }
}

struct AllActivityResponse: Codable {
    var status: Int
    var info: String
    var data: AllActivityData
}

extension AllActivityResponse {
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = AllActivityData(from: json["data"])
    }
}

struct AllActivityData: Codable {
    var ended: [Activity]
    var ongoing: [Activity]
}

extension AllActivityData {
    init(from json: JSON) {
        ended = json["ended"].arrayValue.map { Activity(from: $0) }
        ongoing = json["ongoing"].arrayValue.map { Activity(from: $0) }
    }
}

struct SearchActivityResponse: Codable {
    var status: Int
    var info: String
    var data: [Activity]
}

extension SearchActivityResponse {
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = json["data"].arrayValue.map { Activity(from: $0) }
    }
}

struct StandardResponse: Codable {
    var data: String?
    var status: Int
    var info: String
}

extension StandardResponse {
    init(from json: JSON) {
        data = json["data"].string
        status = json["status"].intValue
        info = json["info"].stringValue
    }
}

struct MineActivityResponse: Codable {
    var status: Int
    var info: String
    var data: MineActivityData
}

extension MineActivityResponse {
    init(from json: JSON) {
        status = json["status"].intValue
        info = json["info"].stringValue
        data = MineActivityData(from: json["data"])
    }
}

struct MineActivityData: Codable {
    var wantToWatch: [Activity]
    var participated: [Activity]
    var reviewing: [Activity]
    var published: [Activity]
    
    private enum CodingKeys: String, CodingKey {
        case wantToWatch = "want_to_watch"
        case participated = "participated"
        case reviewing = "reviewing"
        case published = "published"
    }
}

extension MineActivityData {
    init(from json: JSON) {
        wantToWatch = json["want_to_watch"].arrayValue.map { Activity(from: $0) }
        participated = json["participated"].arrayValue.map { Activity(from: $0) }
        reviewing = json["reviewing"].arrayValue.map { Activity(from: $0) }
        published = json["published"].arrayValue.map { Activity(from: $0) }
    }
}

enum ActivityType {
    case all
    case culture
    case sports
    case education
}

