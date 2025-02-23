//
//  TaskManager.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2024/3/4.
//  Copyright © 2024 Redrock. All rights reserved.
//

import Foundation

class TaskManager: NSObject {
    
    @objc static var shared = TaskManager()
    
    @objc func uploadTaskProgress(title: String, stampCount: Int, remindText: String? = nil) {
        HttpManager.shared.magipoke_intergral_integral_progress(title: title).ry_JSON { response in
            switch response {
            case.success(let jsonData):
                let responseData = StandardResponse(from: jsonData)
                print("任务信息：\(responseData.info)")
                if(responseData.status == 10000) {
                    if let text = remindText {
                        RemindHUD.shared().showDefaultHUD(withText: text)
                    } else {
                        RemindHUD.shared().showDefaultHUD(withText: "完成任务，邮票+\(stampCount)")
                    }
                }
                break
            case.failure(_):
                RemindHUD.shared().showDefaultHUD(withText: "网络错误")
                break
            }
        }
    }
}
