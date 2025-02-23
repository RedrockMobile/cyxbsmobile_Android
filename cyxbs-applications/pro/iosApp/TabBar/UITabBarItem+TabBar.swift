//
//  UITabBarItem+TabBar.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import ObjectiveC

extension UITabBarItem {
    
    static let SMALL_BADGE_TAG = 237
    
    struct Constants {
        static var ry_needMoreSpaceToShow = "CyxbsMobile2019_iOS.UITabBarItem.ry_needMoreSpaceToShow"
    }
    
    var needMoreSpaceToShow: Bool {
        get {
            withUnsafePointer(to: &Constants.ry_needMoreSpaceToShow) {
                objc_getAssociatedObject(self, $0)
            } as? Bool ?? true
        }
        set {
            withUnsafePointer(to: &Constants.ry_needMoreSpaceToShow) {
                objc_setAssociatedObject(self, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var needShowBadgePoint: Bool {
        get {
            badgeValue != nil
        }
        set {
            guard let view = self.value(forKey: "view") as? UIView else { return }
            
            if newValue {
                badgeValue = ""
                
                guard
                let badgeViewClass = NSClassFromString("_UIBadgeView"),
                (view.subviews.last?.isKind(of: badgeViewClass) ?? false)
                else { return }
                
                guard let imgView = view.subviews.first(where: { $0 is UIImageView }) else { return }
                view.subviews.last?.removeFromSuperview()
                let width: CGFloat = 7
                
                let customBadge = UIView(frame: CGRect(x: imgView.frame.maxX - width, y: imgView.frame.minY, width: width, height: width))
                customBadge.tag = UITabBarItem.SMALL_BADGE_TAG
                customBadge.backgroundColor = .red
                customBadge.layer.cornerRadius = width / 2
                customBadge.layer.masksToBounds = true
                customBadge.layer.zPosition = 2
                
                view.addSubview(customBadge)
            } else {
                badgeValue = nil
                
                view.subviews.first { $0.tag == UITabBarItem.SMALL_BADGE_TAG }?.removeFromSuperview()
            }
        }
    }
}
