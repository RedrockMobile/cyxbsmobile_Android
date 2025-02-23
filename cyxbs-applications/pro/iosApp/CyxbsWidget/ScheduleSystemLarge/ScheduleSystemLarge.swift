//
//  ScheduleSystemLarge.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2023/9/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ScheduleSystemLarge: View {
    
    let mappy: RYScheduleMaping
    
    let date: Date
    
    let section: Int
    
    let showPeriod: ClosedRange<Int>
    
    let numberOfShowingInDay = 6
    
    var body: some View {
        
        VStack(spacing: lineSpacing) {
            
            HeaderView
                .frame(height: 30)
            
            GeometryReader { sectionEntry in
                
                VStack {
                    
                    SectionHeaderView
                        .frame(height: heightForSectionHeaderView(fullWidth: sectionEntry.size.width))
                    
                    HStack(spacing: lineSpacing) {
                        
                        SectionLeadingView
                            .frame(width: widthForLeading)
                        
                        
                        GeometryReader { contentEntry in
                                                        
                            ForEach(mappy.datas[section]) { data in
                                
                                ContentView(data: data, size: contentEntry.size)
                            }
                        }
                        .clipped()
                    }
                }
            }
        }
    }
    
    init(mappy: RYScheduleMaping, section: Int, date: Date) {
        self.mappy = mappy
        self.section = section
        self.date = date
        
        let hour = Calendar.current.component(.hour, from: date)
        
        if hour < 10 { showPeriod = createClosedRange(from: 1, lenth: numberOfShowingInDay) }
        else if hour < 12 { showPeriod = createClosedRange(from: 3, lenth: numberOfShowingInDay) }
        else if hour < 16 { showPeriod = createClosedRange(from: 5, lenth: numberOfShowingInDay) }
        else { showPeriod = createClosedRange(from: 7, lenth: numberOfShowingInDay) }
        
        func createClosedRange(from: Int, lenth: Int) -> ClosedRange<Int> {
            from ... (from + lenth - 1)
        }
    }
}

// MARK: View extension

extension ScheduleSystemLarge {
    
    var HeaderView: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text(ScheduleDataFetch.sectionString(withSection: section))
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Color(.ry(light: "#112C54", dark: "#F0F0F2")))
            
            Divider()
                .padding(.bottom, 2)
        }
    }
    
    var SectionHeaderView: some View {
        
        HStack(spacing: columnSpacing) {
            
            ScheduleSupplementaryView(
                title: ScheduleDataFetch.monthString(withSection: section, from: mappy.start),
                content: "",
                drawType: .normal,
                isTitleOnly: true)
            .frame(width: widthForLeading)
            
            ForEach(1 ... 7, id: \.self) { week in
                
                ScheduleSupplementaryView(
                    title: ScheduleDataFetch.weekString(with: week),
                    content: dateFromStart(section: section, week: week)?
                        .string(locale: .cn, format: "d日") ?? "",
                    drawType: isToday(date: dateFromStart(section: section, week: week)) 
                        ? .select
                        : .normal,
                    isTitleOnly: (section == 0 || mappy.start == nil))
            }
        }
    }
    
    var SectionLeadingView: some View {
        
        VStack(alignment: .center, spacing: columnSpacing) {
            
            ForEach(showPeriod, id: \.self) { time in
                
                ScheduleSupplementaryView(
                    title: "\(time)",
                    content: "",
                    drawType: .normal,
                    isTitleOnly: true)
            }
        }
    }
    
    func ContentView(data: RYScheduleMaping.Collection, size: CGSize) -> some View {
        let itemWidth = (size.width + columnSpacing) / 7 - columnSpacing
        let itemHeight = size.height / CGFloat(numberOfShowingInDay) - lineSpacing
        
        return ScheduleCollectionView(
            title: data.cal.curriculum.course,
            content: data.cal.curriculum.classRoom,
            drawType: drawType(in: data.location),
            showMuti: data.count > 1,
            isTitleOnly: data.lenth <= 1)
        .frame(
            width: itemWidth,
            height: itemHeight * CGFloat(data.lenth) + columnSpacing * CGFloat(data.lenth - 1)
        )
        .padding(.leading, (itemWidth + columnSpacing) * CGFloat(data.cal.curriculum.inWeek - 1))
        .padding(.top, CGFloat(data.location - showPeriod.lowerBound) * (itemHeight + lineSpacing))
    }
}

// MARK: Data extension

extension ScheduleSystemLarge {
    
    var widthForLeading: CGFloat { 23 }
        
    var lineSpacing: CGFloat { 2 }
    
    var columnSpacing: CGFloat { 2 }
    
    var aspectRatio: CGFloat { 46.0 / 50.0 }
    
    func heightForSectionHeaderView(fullWidth width: CGFloat) -> CGFloat {
        ((width - widthForLeading) / 7 - lineSpacing) / aspectRatio
    }
    
    func dateFromStart(section: Int, week: Int) -> Date? {
        ScheduleDataFetch.date(withSection: section, week: week, from: mappy.start)
    }
    
    func isToday(date: Date?) -> Bool {
        guard let date else { return false }
        return Calendar.current.isDateInToday(date)
    }
    
    func drawType(in location: Int) -> ScheduleDrawType.CurriculumType {
        if location <= 4 { return .morning }
        
        else if location <= 8 { return .afternoon }
        
        else { return .night }
    }
}
