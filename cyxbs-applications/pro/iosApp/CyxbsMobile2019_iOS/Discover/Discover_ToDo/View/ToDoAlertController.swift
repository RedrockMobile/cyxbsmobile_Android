//
//  ToDoAlertController.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/9/29.
//  Copyright © 2024 Redrock. All rights reserved.
//

import Foundation

class ToDoAlertController: XBSAlertController {
    
    init(confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        super.init(title: "确定是否删除", message: "删除后无法恢复", confirmAction: confirmAction, cancelAction: cancelAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
