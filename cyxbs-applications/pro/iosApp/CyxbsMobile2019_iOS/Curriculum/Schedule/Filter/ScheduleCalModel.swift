//
//  ScheduleCalModel.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

class ScheduleCalModel {
    
    let sno: String
    
    let start: Date?
    
    let inSection: Int
    
    var stu: SearchStudentModel?
    
    let curriculum: CurriculumModel
    
    let customType: ScheduleModel.CustomType
    
    let startCal: Date?
    
    let endCal: Date?
    
    var inWeekStr: String? {
        guard let startCal else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .cn
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: startCal)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let startCal, let endCal {
            return dateFormatter.string(from: startCal) + " - " + dateFormatter.string(from: endCal)
        } else {
            return "No time! ! !"
        }
    }
    
    init(sno: String, start: Date?, inSection: Int, stu: SearchStudentModel?, curriculum: CurriculumModel, customType: ScheduleModel.CustomType = .system) {
        let start = start ?? UserModel.default.start
        self.sno = sno
        self.start = start
        self.inSection = inSection
        self.stu = stu
        self.curriculum = curriculum
        
        var day = start
        if let start {
            day = Calendar.current.date(byAdding: .day, value: (inSection - 1) * 7 + (curriculum.inWeek - 1), to: start)
        }
        startCal = ScheduleCalModel.start(of: day, in: curriculum.period.lowerBound)
        endCal = ScheduleCalModel.end(of: day, in: curriculum.period.upperBound)
        self.customType = customType
    }
}

// MARK: time

extension ScheduleCalModel {
    
    static func start(of day: Date?, in index: Int) -> Date? {
        guard let day else { return nil }
        let startCal = CourseCalComponents.all[get(index: index)].start
        return Calendar.current.date(bySettingHour: startCal.hour ?? 0, minute: startCal.minute ?? 0, second: startCal.second ?? 0, of: day)
    }
    
    static func end(of day: Date?, in index: Int) -> Date? {
        guard let day else { return nil }
        let startCal = CourseCalComponents.all[get(index: index)].end
        return Calendar.current.date(bySettingHour: startCal.hour ?? 0, minute: startCal.minute ?? 0, second: startCal.second ?? 0, of: day)
    }
    
    static func get(index: Int) -> Int {
        min(max(index - 1, 0), CourseCalComponents.all.count - 1)
    }
}

// MARK: ~.CourseCalComponents

extension ScheduleCalModel {
    
    struct CourseCalComponents {
        
        let start: DateComponents
        
        let end: DateComponents
        
        static let all: [CourseCalComponents] = {
            [
                today(h:  8, m: 00) - today(h:  8, m: 45),  // 0
                today(h:  8, m: 55) - today(h:  9, m: 40),
                today(h: 10, m: 15) - today(h: 11, m: 00),
                today(h: 11, m: 10) - today(h: 11, m: 55),
                
                today(h: 14, m: 00) - today(h: 14, m: 45),  // 4
                today(h: 14, m: 55) - today(h: 15, m: 40),
                today(h: 16, m: 15) - today(h: 17, m: 00),
                today(h: 17, m: 10) - today(h: 17, m: 55),
                
                today(h: 19, m: 00) - today(h: 19, m: 45),  // 8
                today(h: 19, m: 55) - today(h: 20, m: 40),
                today(h: 20, m: 50) - today(h: 21, m: 35),
                today(h: 21, m: 45) - today(h: 22, m: 30)
            ]
        }()
        
        static func today(h: Int, m: Int, s: Int = 0) -> DateComponents {
            .init(hour: h, minute: m, second: s)
        }
    }
}

func - (lhs: DateComponents, rhs: DateComponents) -> ScheduleCalModel.CourseCalComponents {
    .init(start: lhs, end: rhs)
}

// MARK: creater

extension ScheduleCalModel {
    
    static func create(with model: ScheduleModel) -> [ScheduleCalModel] {
        model.curriculum.flatMap { course in
            (course.inSections + [0])
                .map { inSection in
                    ScheduleCalModel(sno: model.sno,
                                     start: model.start,
                                     inSection: inSection,
                                     stu: model.student,
                                     curriculum: course,
                                     customType: model.customType)
            }
        }
    }
}
