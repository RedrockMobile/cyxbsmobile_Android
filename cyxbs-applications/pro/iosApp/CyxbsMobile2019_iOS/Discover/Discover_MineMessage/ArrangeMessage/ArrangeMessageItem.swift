//
//  ArrangeMessageItem.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

struct ArrangeMessageItem {
    
    /// 消息id
    let messageID: Int
    /// 是否已读
    let hasRead: Bool
    /// 更新时间
    let updateTime: Int
    /// 是否取消
    let hasCancel: Bool
    /// 日期时间
    let dateDic: [String: Int]
    /// 标题
    let title: String
    /// 是否已开始
    let hasStart: Bool
    /// 人数
    let peopleCount: Int
    /// 类型（发送/接收
    let type: String
    /// 是否已结束
    let hasEnd: Bool
    /// 发送时间
    let publishTime: Int
    /// 是否已添加到日程
    let hasAdd: Bool
    /// 用户学号
    let stuNum: String
    /// 消息内容
    let content: String
    
    init(dictionary dic: [String: Any]) {
        messageID = dic["id"] as! Int
        hasRead = dic["hasRead"] as! Bool
        updateTime = dic["updateTime"] as! Int
        hasCancel = dic["hasCancel"] as! Bool
        dateDic = dic["dateJson"] as! [String: Int]
        title = dic["title"] as! String
        hasStart = dic["hasStart"] as! Bool
        peopleCount = dic["peopleCount"] as! Int
        type = dic["typ"] as! String
        hasEnd = dic["hasEnd"] as! Bool
        publishTime = dic["publishTime"] as! Int
        hasAdd = dic["hasAdd"] as! Bool
        stuNum = dic["StuNum"] as! String
        content = dic["content"] as! String
    }
}
