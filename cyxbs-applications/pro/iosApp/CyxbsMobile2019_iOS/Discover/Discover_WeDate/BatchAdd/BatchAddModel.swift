//
//  BatchAddModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SwiftyJSON

class BatchAddModel {
    
    /// 重复学生数组
    var repeatStudent: [StudentResultItem] = []
    /// 正常学生数组
    var normalStudent: [NormalStudentItem] = []
    /// 错误姓名数组
    var errorName: [String] = []
    /// 是否有错
    var isWrong = Bool()
    
    /// 网络请求检查批量数据
    static func checkDataWithContent(_ content: String, success: ((_ batchAddModel: BatchAddModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let contentAry = content.components(separatedBy: "\n").filter { !$0.isEmpty }
        let parameters: [String: Any] = ["content": contentAry]
        
        HttpTool.share().request(Discover_POST_checkData_API,
                                 type: .post,
                                 serializer: .JSON,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            let batchAddModel = BatchAddModel()
            let json = JSON(object!)
            batchAddModel.isWrong = json["data"]["isWrong"].boolValue
            
            // 有重复
            if json["data"]["repeat"].exists() {
                if let students = json["data"]["repeat"].arrayObject as? [[String: Any]] {
                    for dic in students {
                        let student = StudentResultItem(dictionary: dic)
                        batchAddModel.repeatStudent.append(student)
                    }
                }
            }
            // 有正常
            if json["data"]["normal"].exists() {
                if let students = json["data"]["normal"].arrayObject as? [[String: Any]] {
                    for dic in students {
                        let student = NormalStudentItem(dictionary: dic)
                        batchAddModel.normalStudent.append(student)
                    }
                }
            }
            // 有错误
            if json["data"]["errList"].exists() {
                if let names = json["data"]["errList"].arrayObject as? [String] {
                    for name in names {
                        batchAddModel.errorName.append(name)
                    }
                }
            }
            
            success?(batchAddModel)
        },
                                 failure: { task, error in
            failure?(error)
        })
    }
}
