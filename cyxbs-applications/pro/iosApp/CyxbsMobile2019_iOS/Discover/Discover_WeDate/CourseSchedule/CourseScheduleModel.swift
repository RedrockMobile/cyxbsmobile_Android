//
//  CourseScheduleModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseScheduleModel {
    
    /// 现在周数
    var nowWeek: Int = 0
    /// 日期版本
    var dateVersion: String = ""
    /// 课程信息数组
    var courseAry: [CourseItem] = []
    /// 学生信息
    var student = StudentResultItem(dictionary: [:])
    
    static func requestWithStuNum(_ stuNum: String, success: ((_ courseScheduleModel: CourseScheduleModel) -> Void)?, failure: ((_ error: Error) -> Void)?) {
        let courseScheduleModel = CourseScheduleModel()
        let group = DispatchGroup()
        group.enter()
        HttpTool.share().request(Discover_POST_courseSchedule_API,
                                 type: .post,
                                 serializer: .JSON,
                                 bodyParameters: ["stu_num": stuNum],
                                 progress: nil,
                                 success: { task, object in
            let json = JSON(object!)
            courseScheduleModel.nowWeek = json["nowWeek"].intValue
            courseScheduleModel.dateVersion = json["version"].stringValue
            if let courses = json["data"].arrayObject as? [[String: Any]] {
                for dic in courses {
                    let course = CourseItem(dictionary: dic)
                    courseScheduleModel.courseAry.append(course)
                }
            }
            group.leave()
        },
                                 failure: { task, error in
            failure?(error)
        })
        
        group.enter()
        HttpTool.share().request(Discover_GET_searchStudent_API,
                                 type: .get,
                                 serializer: .HTTP,
                                 bodyParameters: ["stu": stuNum],
                                 progress: nil,
                                 success: { task, object in
            let json = JSON(object!)
            if let dic = json["data"][0].dictionaryObject {
                let student = StudentResultItem(dictionary: dic)
                courseScheduleModel.student = student
            }
            group.leave()
        },
                                 failure: { task, error in
            failure?(error)
        })
        group.notify(queue: .main) {
            success?(courseScheduleModel)
        }
    }
}
