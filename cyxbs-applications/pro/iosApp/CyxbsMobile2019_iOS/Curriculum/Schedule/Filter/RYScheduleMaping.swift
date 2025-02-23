//
//  RYScheduleMaping.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

// MARK: ~.Priority

extension RYScheduleMaping {
    
    enum Priority: Int, Hashable{
        
        case mainly = 0
        
        case custom = 1
        
        case others = 2
        
        static func < (lhs: RYScheduleMaping.Priority, rhs: RYScheduleMaping.Priority) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}

// MARK: ~.Collection

extension RYScheduleMaping {
    
    struct Collection: Equatable {
        
        let cal: ScheduleCalModel
        
        let location: Int
        
        var lenth: Int = 1
        
        let priority: Priority
        
        var count: Int = 1
        
        init(cal: ScheduleCalModel, location: Int, priority: Priority) {
            self.cal = cal
            self.location = location
            self.priority = priority
        }
        
        static func == (lhs: RYScheduleMaping.Collection, rhs: RYScheduleMaping.Collection) -> Bool {
            lhs.cal === rhs.cal
        }
    }
}

// MARK: ScheduleMaping

class RYScheduleMaping {
    
    var name: String? = nil
    
    var start: Date? = nil
    
    var nowWeek: Int = 0
    
    // if you don't want to have a diffirent views, set it to false
    var checkPriority: Bool = true
    
    // {2021215154, .system} -> .mainly
    private(set) var scheduleModelMap: [ScheduleModel: Priority] = [:]
    
    // (section, week) -> {ScheduleCalModel, ScheduleCalModel, nil, ...}
    private var mapTable: [IndexPath: [Collection?]] = [:]
    
    private var oldValues: [Collection] = []
    
    // the final data to show on view
    private var finalData: [[Collection]] = [[]]
    var datas: [[Collection]] {
        if !didFinished { finish() }
        return finalData
    }
    
    // if didFinished, mapTable is available
    private var didFinished: Bool = false
}

extension RYScheduleMaping {
    
    func findCals(from collection: Collection) -> [ScheduleCalModel] {
        var cals = [collection.cal]
        for oldValue in self.oldValues {
            if oldValue.cal.inSection == collection.cal.inSection,
            oldValue.cal.curriculum.inWeek == collection.cal.curriculum.inWeek,
            (oldValue.location ..< (oldValue.location + oldValue.lenth)).contains(collection.location) {
                cals.append(oldValue.cal)
            }
        }
        return cals
    }
}

// MARK: mapping

extension RYScheduleMaping {
    
    // map a ScheduleModel on mapTable, O(n * m), n: section, m: lenth
    func maping(_ model: ScheduleModel, prepare cals: [ScheduleCalModel]? = nil, priority: Priority = .mainly) {
        if model.customType == .system {
            start = model.start
            nowWeek = model.nowWeek
        }
        if scheduleModelMap[model] != nil { return }
        didFinished = false
        scheduleModelMap[model] = priority
        let cals = cals ?? model.calModels
        for cal in cals {
            for idx in cal.curriculum.period {
                let pointCal = Collection(cal: cal, location: idx, priority: priority)
                map(pCal: pointCal)
            }
        }
    }
    
    private func map(pCal: Collection) {
        let indexPath = IndexPath(indexes: [pCal.cal.inSection, pCal.cal.curriculum.inWeek])
        var ary = mapTable[indexPath] ?? []
        if ary.count <= pCal.location {
            for _ in ary.count ... pCal.location {
                ary.append(nil)
            }
        }
        
        // do not check priority to layout
        
        if !checkPriority {
            abandon_the_old_for_the_new()
            return
        }
        
        // if is old exist
        
        guard let old = ary[pCal.location] else {
            abandon_the_old_for_the_new()
            return
        }
        
        // abandon the old for the new
        
        if pCal.priority < old.priority {
            abandon_the_old_for_the_new(old: old)
            return
        }
        
        if pCal.priority == old.priority {
            if pCal.cal.curriculum.period.count >= old.cal.curriculum.period.count {
                abandon_the_old_for_the_new(old: old)
                return
            }
        }
        
        firm_and_unshakable(old: &ary[pCal.location]!)
        
        func abandon_the_old_for_the_new(old: Collection? = nil) {
            var new = pCal
            if let old {
                oldValues.append(old)
                new.count += 1
            }
            ary[pCal.location] = new
            mapTable[indexPath] = ary
        }
        
        func firm_and_unshakable(old: inout Collection) {
            oldValues.append(pCal)
            old.count += 1
        }
    }
}

// MARK: delete

extension RYScheduleMaping {
    
    func delete(pCal: Collection) {
        didFinished = false
        var pCal = pCal
        pCal.count = 1
        let indexPath = IndexPath(indexes: [pCal.cal.inSection, pCal.cal.curriculum.inWeek])
        guard var ary = mapTable[indexPath] else { return }
        ary[pCal.location] = nil
        
        for i in 0 ..< oldValues.count {
            let oldValue = oldValues[i]
            if oldValue.cal.inSection == pCal.cal.inSection &&
                oldValue.cal.curriculum.inWeek == pCal.cal.curriculum.inWeek &&
                oldValue.location == pCal.location {
                
                oldValues.remove(at: i)
                map(pCal: oldValue)
            }
        }
    }
}

// MARK: finish

extension RYScheduleMaping {
    
    // finished mapTable to finalData
    func finish() {
        if didFinished { return }
        didFinished = true
        finalData = [[]]
        
        for each in mapTable {
            if finalData.count <= each.key[0] {
                for _ in finalData.count ... each.key[0] {
                    finalData.append([])
                }
            }
            
            if each.value.count <= 1 { continue }
            
            var oldValue = each.value[0]
            
            for newIndex in 1 ..< each.value.count {
                let newValue = each.value[newIndex]
                if oldValue != newValue {
                    if let newValue {
                        var collection = Collection(cal: newValue.cal, location: newIndex, priority: newValue.priority)
                        collection.count = newValue.count
                        finalData[each.key[0]].append(collection)
                    }
                } else {
                    if newValue != nil, finalData[each.key[0]].count > 0 {
                        finalData[each.key[0]][finalData[each.key[0]].count - 1].lenth += 1
                    }
                }
                oldValue = newValue
            }
        }
    }
}

// MARK: clean

extension RYScheduleMaping {
    
    func clean() {
        scheduleModelMap = [:]
        mapTable = [:]
        oldValues = []
        finalData = [[]]
        didFinished = false
    }
}
