//
//  ScheduleCalModel+EX.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/23.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

extension ScheduleCalModel: UNManagerPushable {
    
    var identifier: String {
        "curriculum \(customType) \(stu?.stunum ?? "") \(inSection) \(curriculum.inWeek) \(curriculum.period.lowerBound) \(curriculum.courseID ?? "")"
    }
    
    var title: String {
        "上课啦: \(curriculum.course)"
    }
    
    var subtitle: String {
        "地点: \(curriculum.classRoom)"
    }
    
    var body: String {
        ""
    }
    
    var beginTime: Date {
        Date()
    }
}
