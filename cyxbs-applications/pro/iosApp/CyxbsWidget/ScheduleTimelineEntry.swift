//
//  ScheduleTimelineEntry.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2023/1/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

import WidgetKit
import Intents

struct ScheduleTimelineEntry: TimelineEntry {
    let date: Date // update time
    
    /* configuration
     * 如果以后采用动态的configuration时，请注意创建的方法
     */
    let configuration: ScheduleWidgetConfiguration
    
    /* section
     * nil则表示跟随变化而变化，非nil则表示固定某个周
     * 注意在后期数据处理的时候，是否与configuration有重复定义
     */
    var section: Int?
    
    var models: [ScheduleModel]
    
    var errorMsg: String?
    
    init(date: Date, configuration: ScheduleWidgetConfiguration = .init()) {
        self.date = date
        self.configuration = configuration
        models = []
    }
}
