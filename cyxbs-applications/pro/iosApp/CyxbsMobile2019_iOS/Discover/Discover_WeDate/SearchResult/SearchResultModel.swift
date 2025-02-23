//
//  SearchResultModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/8/13.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchResultModel {
    
    /// 输入数据是否存在
    var isExist: Bool = true
    /// 搜索信息为何种类型
    var types: [String] = []
    /// 学生信息数组
    var studentAry: [StudentResultItem] = []
    /// 班级信息数组
    var classAry: [ClassResultItem] = []
    /// 分组信息数组
    var groupAry: [GroupResultItem] = []
    
    static func requestWithKey(_ key: String, success: ((_ searchResultModel: SearchResultModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let parameters = ["key": key]
        HttpTool.share().request(Discover_GET_temporaryGroup_API,
                                 type: .get,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            let searchResultModel = SearchResultModel()
            let json = JSON(object!)
            // 搜索结果为学生
            if let types = json["data"]["types"].array?.map({ $0.stringValue }) {
                searchResultModel.types = types
            }
            
            if searchResultModel.types == ["学生"] {
                if let students = json["data"]["students"].arrayObject as? [[String: Any]] {
                    for dic in students {
                        let student = StudentResultItem(dictionary: dic)
                        searchResultModel.studentAry.append(student)
                    }
                }
            // 搜索结果为班级
            } else if searchResultModel.types == ["班级"] {
                if let classInformation = json["data"]["class"].dictionaryObject {
                    let classInfo = ClassResultItem(dictionary: classInformation)
                    searchResultModel.classAry.append(classInfo)
                }
            // 搜索结果为分组
            } else if searchResultModel.types == ["分组"] {
                if let groupInformation = json["data"]["group"].dictionaryObject {
                    let groupInfo = GroupResultItem(dictionary: groupInformation)
                    searchResultModel.groupAry.append(groupInfo)
                }
            // 搜索结果为学生+分组（学生名和组名同名时
            } else if searchResultModel.types == ["学生", "分组"] {
                if let students = json["data"]["students"].arrayObject as? [[String: Any]] {
                    for dic in students {
                        let student = StudentResultItem(dictionary: dic)
                        searchResultModel.studentAry.append(student)
                    }
                }
                if let groupInformation = json["data"]["group"].dictionaryObject {
                    let groupInfo = GroupResultItem(dictionary: groupInformation)
                    searchResultModel.groupAry.append(groupInfo)
                }
            } else {
                searchResultModel.isExist = false
            }
            
            success?(searchResultModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
}
