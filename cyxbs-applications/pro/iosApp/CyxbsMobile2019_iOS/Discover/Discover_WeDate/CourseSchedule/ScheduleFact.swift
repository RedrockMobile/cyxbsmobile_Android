//
//  ScheduleFact.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import MJRefresh

protocol ScheduleFactDelegate: AnyObject {
    func updateCpllectionViewPageNum(_ num: Int)
    func didSelectItemWith(_ studentAry: [StudentResultItem], _ timePeriod: String, _ timeDic: [String: Int])
}

class ScheduleFact: NSObject {
    
    private(set) var collectionView: UICollectionView!
    
    weak var delegate: ScheduleFactDelegate?
    
    private var scrollViewStartPosPoint: CGPoint = .zero
    
    private var scrollDirection: Int = 0
    
    // 课表数据初始化为空
    private var data: [[[String: Any]]] = Array(repeating: [[String: Any]](), count: 26)
    
    // 标志位数组，标志当周的课程安排是否被请求
    private var flagArray = Array(repeating: false, count: 26)
    
    private var dateVersion: String = ""
    
    private var stuNumAry: [String] = []
    
    private var nowWeek: Int = 0
    
    init(stuNumAry: [String], dateVersion: String, nowWeek: Int) {
        super.init()
        self.stuNumAry = stuNumAry
        self.dateVersion = dateVersion
        self.nowWeek = nowWeek
        // 先加载全部周和当周课表
        updateWeeklySchedule(forWeek: 0)
        // 如果当前周数不在学期内（会导致数组越界），则不加载当周课表
        if nowWeek <= 26 {
            updateWeeklySchedule(forWeek: nowWeek)
        }
    }
    
    // 更新某周的课表
    func updateWeeklySchedule(forWeek week: Int) {
        if !flagArray[week] {
            WeekMaping.mapWeekToAry(stuNumAry: stuNumAry, weekNum: week) { weekAry in
                self.data[week] = WeekMaping.processWeekArray(weekAry: weekAry, weekNum: week)
                self.flagArray[week] = true
                self.collectionView.reloadSections(IndexSet(integer: week))
                // 新加载的课表cell渐入
                for cell in self.collectionView.visibleCells {
                    if let indexPath = self.collectionView.indexPath(for: cell), indexPath.section == week {
                        cell.alpha = 0
                        UIView.animate(withDuration: 0.3) {
                            cell.alpha = 1
                        }
                    }
                }
            }
        }
    }
}

extension ScheduleFact {
    
    var currentPage: Int {
        Int(collectionView.contentOffset.x / collectionView.bounds.width / CGFloat(collectionView.ry_layout?.pageShows ?? 1) + 0.5)
    }
    
    @objc
    func createCollectionView() -> UICollectionView {
        let layout = ScheduleCollectionViewLayout()
        layout.lineSpacing = 2
        layout.columnSpacing = 2
        layout.widthForLeadingSupplementaryView = 30
        layout.dataSource = self
        layout.delegate = self
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.decelerationRate = .fast
        collectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleCollectionViewCell.curriculumReuseIdentifier)
        let elementKinds: [UICollectionView.ElementKindSection] =
        [.header, .leading]
        for elementKind in elementKinds {
            collectionView.register(ScheduleCollectionViewCell.self, forSupplementaryViewOfKind: elementKind.rawValue, withReuseIdentifier: ScheduleCollectionViewCell.supplementaryReuseIdentifier)
            layout.register(ScheduleCollectionViewCell.self, forSupplementaryViewOfKind: elementKind.rawValue)
        }
        self.collectionView = collectionView
        return collectionView
    }
}

// MARK: UICollectionViewDataSource

extension ScheduleFact: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //每周总共的课程数
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = data[indexPath.section][indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.curriculumReuseIdentifier, for: indexPath) as! ScheduleCollectionViewCell
        
        var drawType: ScheduleCollectionViewCell.DrawType.CurriculumType = .allBusy
        
        guard let student = item["student"] as? [StudentResultItem] else { return cell }
        
        var title = String(student.count) + "人忙碌"
        
        if student.isEmpty {
            drawType = .allLeisure
            title = ""
        } else {
            if student.count == stuNumAry.count {
                drawType = .allBusy
                title = "全员忙碌"
            } else if student.count > stuNumAry.count / 2 {
                drawType = .busyMore
            } else {
                drawType = .leisureMore
            }
        }
        
        cell.set(curriculumType: drawType, title: title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ScheduleCollectionViewCell.supplementaryReuseIdentifier, for: indexPath) as! ScheduleCollectionViewCell
        
        let kind = UICollectionView.ElementKindSection(rawValue: kind) ?? .header
        
        switch kind {
            
        case .header:
            var title = ""
            var content = ""
            var isTitleOnly: Bool = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.M.d"
            var isToday: Bool = false
            if let startDate = dateFormatter.date(from: dateVersion),
               let BJDate = Calendar(identifier: .gregorian).date(byAdding: .hour, value: 8, to: startDate),
               let date = Calendar(identifier: .gregorian).date(byAdding: .day, value: (indexPath.section - 1) * 7 + indexPath.item - 1, to: BJDate) {
                if indexPath.item != 0 {
                    let weekday = Calendar(identifier: .gregorian).component(.weekday, from: date)
                    let weekdays = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
                    title = weekdays[weekday - 1]
                    // 若为当天则加深所在列颜色
                    let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
                    let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
                    
                    if todayComponents.year == dateComponents.year,
                       todayComponents.month == dateComponents.month,
                       todayComponents.day == dateComponents.day {
                        isToday = true
                        
                        let todayView = UIView()
                        todayView.backgroundColor = UIColor(hexString: "#F3F6FD", alpha: 1)
                        todayView.frame = cell.frame
                        todayView.origin.y = -collectionView.bounds.height / 2
                        todayView.height = collectionView.bounds.height * 2
                        collectionView.insertSubview(todayView, at: 0)
                    }
                }
                
                if indexPath.section != 0,
                   indexPath.item == 0 {
                    title = String(Calendar(identifier: .gregorian).component(.month, from: date)) + "月"
                    isTitleOnly = true
                }
                
                if indexPath.section != 0,
                   indexPath.item != 0 {
                    content = String(Calendar(identifier: .gregorian).component(.day, from: date)) + "日"
                }
            }
            
            cell.set(supplementaryType: isToday ? .today : .normal, title: title, content: content, isTitleOnly: isTitleOnly, isNeedTimePointer: false)
            cell.backgroundColor = collectionView.backgroundColor
            
        case .leading:
            let title = "\(indexPath.item + 1)"
            
            var isNeedTimePointer: Bool = false
            
            let timeAry = [["hour": 8, "minute": 00], ["hour": 8, "minute": 45], ["hour": 9, "minute": 40], ["hour": 11, "minute": 00], ["hour": 11, "minute": 55], ["hour": 14, "minute": 45], ["hour": 15, "minute": 40], ["hour": 17, "minute": 00], ["hour": 17, "minute": 55], ["hour": 19, "minute": 45], ["hour": 20, "minute": 40], ["hour": 21, "minute": 35], ["hour": 22, "minute": 30]]
            
            for i in 0..<timeAry.count-1 {
                let current = Date()
                let currentPoint = Calendar.current.date(bySettingHour: timeAry[i]["hour"]!, minute: timeAry[i]["minute"]!, second: 0, of: current)!
                let nextPoint = Calendar.current.date(bySettingHour: timeAry[i+1]["hour"]!, minute: timeAry[i+1]["minute"]!, second: 0, of: current)!
                if current >= currentPoint && current < nextPoint,
                   indexPath.item == i {
                    isNeedTimePointer = true
                    break
                }
            }
            
            cell.set(supplementaryType: .normal, title: title, content: nil, isTitleOnly: true, isNeedTimePointer: isNeedTimePointer)
            
//        case .placeHolder:
//            break，
            
//        case .pointHolder:
//            break
        default:
            break
        }
        
        return cell
    }
}

// MARK: ScheduleCollectionViewLayoutDataSource

extension ScheduleFact: ScheduleCollectionViewLayoutDataSource {

    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, columnOfItemAtIndexPath indexPath: IndexPath) -> Int {
        //这周的这门课在星期几
        return data[indexPath.section][indexPath.item]["dayNum"] as! Int
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, lineOfItemAtIndexPath indexPath: IndexPath) -> Int {
        //这周的这门课在第几节开始
        return data[indexPath.section][indexPath.item]["beginLesson"] as! Int
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, lenthOfItemAtIndexPath indexPath: IndexPath) -> Int {
        //这周的这门课的长度
        return data[indexPath.section][indexPath.item]["length"] as! Int
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, numberOfSupplementaryOfKind kind: String, inSection section: Int) -> Int {
        guard let kind = UICollectionView.ElementKindSection(rawValue: kind) else { return 0 }
        switch kind {
        case .header:
            return 8
        case .leading:
            return 12
//        case .placeHolder:
//            return 0
//        case .pointHolder:
//            return 0
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, persentOfPointAtIndexPath indexPath: IndexPath) -> CGFloat {
        1
    }
}

// MARK: UICollectionViewDelegate

extension ScheduleFact: UICollectionViewDelegate {
    
    func reloadHeaderView() {
        let page = currentPage
        delegate?.updateCpllectionViewPageNum(page)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let collectionView = scrollView as! UICollectionView
        let layout = collectionView.collectionViewLayout as! ScheduleCollectionViewLayout
        layout.pageCalculation = Int(scrollView.contentOffset.x / scrollView.bounds.size.width) * layout.pageShows
        scrollViewStartPosPoint = scrollView.contentOffset
        scrollDirection = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        reloadHeaderView()
        
        if scrollDirection == 0 {
            if abs(scrollViewStartPosPoint.x - scrollView.contentOffset.x) <
                abs(scrollViewStartPosPoint.y - scrollView.contentOffset.y) {
                // 垂直滑动
                scrollDirection = 1
            } else {
                // 水平滑动
                scrollDirection = 2
            }
        }
        
        if scrollDirection == 1 {
            scrollView.contentOffset = CGPoint(x: scrollViewStartPosPoint.x, y: scrollView.contentOffset.y)
        } else {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollViewStartPosPoint.y)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate { scrollDirection = 0 }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDirection = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedStudentAry: [StudentResultItem] = []
        for student in data[indexPath.section][indexPath.item]["student"] as! [StudentResultItem] {
            selectedStudentAry.append(student)
        }
        let weekdays = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
        let weekday = weekdays[data[indexPath.section][indexPath.item]["dayNum"] as! Int - 1]
        let beginTimeNum = data[indexPath.section][indexPath.item]["beginLesson"] as! Int
        let endTimeNum = beginTimeNum + (data[indexPath.section][indexPath.item]["length"] as! Int) - 1
        let time = data[indexPath.section][indexPath.item]["timePeriod"] as! String
        let timePeriod = weekday + " " + String(beginTimeNum) + "～" + String(endTimeNum) + " " + time
        let timeDic = [
            "beginLesson": beginTimeNum,
            "day": data[indexPath.section][indexPath.item]["dayNum"] as! Int,
            "period": data[indexPath.section][indexPath.item]["length"] as! Int - 1,
            "week": indexPath.section
        ]
        delegate?.didSelectItemWith(selectedStudentAry, timePeriod, timeDic)
        
        if selectedStudentAry.isEmpty {
            let cell = collectionView.cellForItem(at: indexPath) as! ScheduleCollectionViewCell
            cell.contentView.backgroundColor = .gray.withAlphaComponent(0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.animate(withDuration: 0.5) {
                    cell.contentView.backgroundColor = .clear
                }
            }
        }
    }
}

extension ScheduleFact: ScheduleCollectionViewLayoutDelegate {
    func pageWillScrollTo(page: Int) {
        updateWeeklySchedule(forWeek: page)
    }
}
