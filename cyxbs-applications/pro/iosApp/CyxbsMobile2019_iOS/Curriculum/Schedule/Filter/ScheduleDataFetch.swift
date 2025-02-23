//
//  ScheduleDataFetch.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2023/9/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

let ScheduleDataFetch = ScheduleData.fetch

struct ScheduleData {
    
    static let fetch = ScheduleData()
    
    private init() { }
    
    func sectionString(withSection section: Int) -> String {
        if section >= 1 {
            let formatter = NumberFormatter()
            formatter.locale = .cn
            formatter.numberStyle = .spellOut
            if let num = formatter.string(from: section as NSNumber) {
                return "第" + num + "周"
            }
        }
        return "整学期"
    }
    
    func monthString(withSection section: Int, from: Date?) -> String {
        guard let from, section >= 1 else { return "学期" }
        let currenDay = Calendar.current.date(byAdding: .day, value: (section - 1) * 7, to: from) ?? Date()
        return currenDay.string(locale: .cn, format: "M月")
    }
    
    func date(withSection section: Int, week: Int, from: Date?) -> Date? {
        guard let from, section >= 1 else { return nil }
        return Calendar.current.date(byAdding: .day, value: (section - 1) * 7 + (week - 1), to: from) ?? Date()
    }
    
    func weekString(with week: Int) -> String {
        let monday = Calendar.current.date(bySetting: .weekday, value: 2, of: Date()) ?? Date()
        let curDay = Calendar.current.date(byAdding: .day, value: week - 1, to: monday) ?? Date()
        return curDay.string(locale: .cn, format: "EEE")
    }
}

extension RYScheduleMaping.Collection: Identifiable {
    
    var id: IndexPath {
        IndexPath(arrayLiteral: cal.inSection, cal.curriculum.inWeek, location)
    }
}
