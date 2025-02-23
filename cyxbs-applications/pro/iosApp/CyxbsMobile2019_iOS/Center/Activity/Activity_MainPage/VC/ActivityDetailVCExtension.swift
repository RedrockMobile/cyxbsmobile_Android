//
//  ActivityDetailVCExtension.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/10/31.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation

extension ActivityDetailVC {
    // MARK: - 获取time的天时分秒
    func formatTime(_ time: Double) -> (Int, Int, Int, Int) {
        let days = Int(time) / 86400
        let hours = (Int(time) % 86400) / 3600
        let minutes = (Int(time) % 3600) / 60
        let seconds = Int(time) % 60
        
        return (days, hours, minutes, seconds)
    }
    
    // MARK: - 时间戳转换为显示的字符串
    func formatTimestamp(timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日HH点mm分"
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
