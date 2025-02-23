//
//  JudgeArrangeMessage.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/14.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class JudgeArrangeMessage: NSObject {
    
    @objc
    static func judgetabBarRedDot() {
        ArrangeMessageModel.getReceivedMessage { groupModel in
            var needRedPot = false
            for message in groupModel.messageAry {
                if !message.hasRead {
                    needRedPot = true
                    break
                }
            }
            if let window = UIApplication.shared.windows.first,
               let tabBarController = window.rootViewController as? UITabBarController {
//                tabBarController.viewControllers?.last?.tabBarItem.needShowBadgePoint = needRedPot
            }
            
        } failure: { error in
            print(error)
        }
    }
    
    @objc
    static func isNeedRedDot(completion: @escaping (Bool) -> Void) {
        var needRedPot = false
        ArrangeMessageModel.getReceivedMessage { groupModel in
            for message in groupModel.messageAry {
                if !message.hasRead {
                    needRedPot = true
                    break
                }
            }
            completion(needRedPot)
        } failure: { error in
            print(error)
        }
    }
    
    @objc
    static func needRedDotNumber(completion: @escaping (Int) -> Void) {
        var count = 0
        ArrangeMessageModel.getReceivedMessage { groupModel in
            for message in groupModel.messageAry {
                if !message.hasRead {
                    count += 1
                }
            }
            completion(count)
        } failure: { error in
            print(error)
        }
    }
}
