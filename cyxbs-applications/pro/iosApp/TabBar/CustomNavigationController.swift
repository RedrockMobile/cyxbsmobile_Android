//
//  CustomNavigationController.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/4/8.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = true
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if topViewController == viewControllers.first {
                // 已经是根视图控制器，不执行返回操作，直接结束交互式转场
                return false
            } else {
                // 开始新的交互式转场
                return true
            }
        }
        return true
    }
}

