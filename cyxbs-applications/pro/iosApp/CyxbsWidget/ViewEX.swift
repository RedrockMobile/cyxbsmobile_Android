//
//  ViewEX.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import SwiftUI
import WidgetKit

extension View {
    
    @ViewBuilder
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOS 17.0, *) {
            containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            background(backgroundView)
        }
    }
}

extension APIConfig {
    
    func api(_ api: String) -> String {
        // 原URL请求
        let url = environment.url + api
        return url
    }
}
