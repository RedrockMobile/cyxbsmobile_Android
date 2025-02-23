//
//  CyxbsWidgetBundle.swift
//  CyxbsWidget
//
//  Created by SSR on 2023/9/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct CyxbsWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        
        ScheduleWidget()
        
        if #available(iOS 16.1, *) {
            CyxbsWidgetLiveActivity()
        }
    }
}
