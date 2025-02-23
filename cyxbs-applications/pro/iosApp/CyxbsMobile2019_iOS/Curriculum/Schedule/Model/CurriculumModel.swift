//
//  CurriculumModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CurriculumModel: Codable, Equatable {
    
    var inWeek: Int = 0
    
    var inSections: IndexSet = .init()
    
    var period = 0...0

    var course: String = ""
    
    var classRoom: String = ""

    var type: String = ""
    
    var courseID: String?
    
    var rawWeek: String?
    
    var teacher: String?
    
    var lesson: String?
}

extension CurriculumModel {
    
    init(json: JSON) {
        inWeek = json["hash_day"].intValue + 1
        
        json["week"].arrayValue.forEach { eachWeek in
            inSections.insert(eachWeek.intValue)
        }
        
        let location = json["begin_lesson"].intValue
        let lenth = max(1, json["period"].intValue)
        period = location ... (location + lenth - 1)
        
        course = json["course"].stringValue
        classRoom = json["classroom"].stringValue
        
        type = json["type"].stringValue
        courseID = json["course_num"].string
        rawWeek = json["rawWeek"].string
        teacher = json["teacher"].string
        lesson = json["lesson"].string
    }
    
    init(cus json: JSON) {
        guard let date = json["date"].arrayValue.first else { return }
        
        inWeek = date["day"].intValue + 1
        
        date["week"].arrayValue.forEach { eachWeek in
            inSections.insert(eachWeek.intValue)
        }
        
        let location = date["begin_lesson"].intValue
        let lenth = max(1, date["period"].intValue)
        period = location ... (location + lenth - 1)
        
        course = json["title"].stringValue
        classRoom = json["content"].stringValue
        
        type = "事务"
        courseID = json["id"].stringValue
        teacher = "自定义"
       
        commitCus()
    }
    
    mutating func commitCus() {
        rawWeek = inSections.rangeView.map { "\($0.lowerBound)-\($0.upperBound - 1)" }.joined(separator: ", ") + "周"
        let formatter = NumberFormatter()
        formatter.locale = .cn
        formatter.numberStyle = .spellOut
        lesson = period.map { formatter.string(from: $0 as NSNumber) ?? "" }.joined() + "节"
    }
}
