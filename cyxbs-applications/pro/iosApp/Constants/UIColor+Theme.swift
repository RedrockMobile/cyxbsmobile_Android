//
//  UIColor+Theme.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/4.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

func hexStrToInt(_ str: String) -> CGFloat {
    var result: UInt64 = 0
    let scanner = Scanner(string: str)
    scanner.scanHexInt64(&result)
    return CGFloat(result)
}



extension UIColor {
    
    convenience init?(hexString: String) {
        var str = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if str.hasPrefix("#") {
            str = String(str.dropFirst())
        } else if str.hasPrefix("0X") {
            str = String(str.dropFirst(2))
        }

        let length = str.count
        guard length == 3 || length == 4 || length == 6 || length == 8 else {
            return nil
        }

        var rgba: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1)

        if length < 5 {
            rgba.0 = hexStrToInt(String(str.prefix(1))) / 255.0
            rgba.1 = hexStrToInt(String(String(str.prefix(2)).suffix(1))) / 255.0
            rgba.2 = hexStrToInt(String(str.suffix(1))) / 255.0
            if length == 4 {
                rgba.3 = hexStrToInt(String(str.suffix(1))) / 255.0
            }
        } else {
            rgba.0 = hexStrToInt(String(str.prefix(2))) / 255.0
            rgba.1 = hexStrToInt(String(String(str.prefix(4)).suffix(2))) / 255.0
            rgba.2 = hexStrToInt(String(String(str.prefix(6)).suffix(2))) / 255.0
            if length == 8 {
                rgba.3 = hexStrToInt(String(str.suffix(2))) / 255.0
            }
        }

        self.init(red: rgba.0, green: rgba.1, blue: rgba.2, alpha: rgba.3)
    }
    
    class func hex(_ hexString: String) -> UIColor {
        UIColor(hexString: hexString) ?? .clear
    }
    
    func a(_ str: String) -> UIColor {
        let length = str.count
        guard length == 1 || length == 2 else { return self }
        return withAlphaComponent(hexStrToInt(str) / 255.0)
    }
}

extension UIColor {
    
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
    
    static func ry(light: String, dark: String) -> UIColor {
        UIColor(light: .hex(light), dark: .hex(dark))
    }
}
