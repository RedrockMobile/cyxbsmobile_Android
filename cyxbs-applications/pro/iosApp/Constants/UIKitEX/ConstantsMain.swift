//
//  ConstantsMain.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/29.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

// MARK: keyWindow

public extension _constants {
        
    @available(iOS 13, *)
    var scene: UIWindowScene? {
        UIApplication.shared.connectedScenes.compactMap { scene in
            if let scene = (scene as? UIWindowScene) {
                return scene
            }
            return nil
        }.first
    }
    
    var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return scene?.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    var safeDistanceTop: CGFloat {
        keyWindow?.safeAreaInsets.top ?? 0
    }
    
    var safeDistanceBottom: CGFloat {
        keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    // UIStatusBarManager
    
    var statusBarFrame: CGRect {
        if #available(iOS 13.0, *) {
            return scene?.statusBarManager?.statusBarFrame ?? .zero
        } else {
            return UIApplication.shared.statusBarFrame
        }
    }
    
    var statusBarHeight: CGFloat {
        statusBarFrame.height
    }
    
    var statusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return scene?.statusBarManager?.statusBarStyle ?? .default
        } else {
            return UIApplication.shared.statusBarStyle
        }
    }
    
    var isStatusBarHidden: Bool {
        if #available(iOS 13.0, *) {
            return scene?.statusBarManager?.isStatusBarHidden ?? false
        } else {
            return UIApplication.shared.isStatusBarHidden
        }
    }
    
    // UIInterfaceOrientation
    
    var interfaceOrientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return scene?.interfaceOrientation
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
    
    var isLandscape: Bool {
        interfaceOrientation?.isLandscape ?? false
    }
    
    var isPortrait: Bool {
        interfaceOrientation?.isPortrait ?? false
    }
}
