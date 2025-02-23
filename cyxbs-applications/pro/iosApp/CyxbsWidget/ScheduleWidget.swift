//
//  ScheduleWidget.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2022/12/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ScheduleWidget: Widget {
    
    let kind: String = CyxbsWidgetKind.schedule

    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: ScheduleWidgetConfiguration.self, provider: ScheduleProvider()) { entry in
            
            ScheduleWidgetEntryView(entry: entry)
                .widgetBackground(Color(UIColor.systemBackground))
        }
        .configurationDisplayName("掌邮课表")
        .description("快来添加你的课表小组件吧！")
        .supportedFamilies(supportedFamilies)
    }
}

extension ScheduleWidget {
    var supportedFamilies: Array<WidgetFamily> {
        return [.systemLarge]
//        var ary: Array<WidgetFamily> = [.systemSmall, .systemMedium, .systemLarge]
//        if #available(iOS 15.0, *) {
//            ary.append(.systemExtraLarge)
//        }
//        if #available(iOS 16.0, *) {
//            ary.append(.accessoryCircular)
//            ary.append(.accessoryRectangular)
//            ary.append(.accessoryInline)
//        }
//        return ary
    }
}
