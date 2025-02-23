//
//  UIAlterControllerFast.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func normalType(title: String?, content: String?, cancelText: String? = "取消", sureText: String? = "确定", action: ((UIAlertAction) -> ())?) -> UIAlertController {
        let alterVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelText, style: .cancel, handler: action)
        let sureAction = UIAlertAction(title: sureText, style: .default, handler: action)
        alterVC.addAction(cancelAction)
        alterVC.addAction(sureAction)
        return alterVC
    }
}
