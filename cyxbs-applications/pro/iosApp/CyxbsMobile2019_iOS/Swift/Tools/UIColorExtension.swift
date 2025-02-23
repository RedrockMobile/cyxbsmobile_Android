//
//  UIColor+DM.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/7/23.
//  Copyright © 2023 Redrock. All rights reserved.
//

import Foundation
import UIKit
//浅（深）色模式颜色适配
extension UIColor {
    static func dm_color(withLightColor lightColor: UIColor, darkColor: UIColor, alpha: CGFloat) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? darkColor.withAlphaComponent(alpha) : lightColor.withAlphaComponent(alpha)
            }
        } else {
            return lightColor.withAlphaComponent(alpha)
        }
    }
    
    static func dm_color(withLightColor lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return darkColor
                } else {
                    return lightColor
                }
            }
        } else {
            // If running on iOS versions prior to iOS 13, return the lightColor.
            return lightColor
        }
    }
    
    /*convenience init?(hexString: String) {
        var cleanedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cleanedString.hasPrefix("#") {
            cleanedString.remove(at: cleanedString.startIndex)
        }

        if cleanedString.count != 6 {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cleanedString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }*/
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if formattedString.hasPrefix("#") {
            formattedString.remove(at: formattedString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


