//
//  DeviceTest.swift
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/5/30.
//  Copyright © 2021 Redrock. All rights reserved.
//

//参考文章：https://www.jianshu.com/p/d920885d6a02

import UIKit

@objc enum DeviceType:Int {
    case Unknown = 0,
    Simulator,
    IPhone_1G,          //基本不用
    IPhone_3G,          //基本不用
    IPhone_3GS,         //基本不用
    IPhone_4,           //基本不用
    IPhone_4s,          //基本不用
    IPhone_5,
    IPhone_5C,
    IPhone_5S,
    IPhone_SE1,
    IPhone_6,
    IPhone_6P,
    IPhone_6s,
    IPhone_6s_P,
    IPhone_7,
    IPhone_7P,
    IPhone_8,
    IPhone_8P,
    IPhone_X,
    iPhone_XR,
    iPhone_XS,
    iPhone_XS_Max
}

@objc enum DeviceHardwareLevel:Int {
    case Low, Medium, High
}

public class DeviceUtil: NSObject {
    
    private var _type:DeviceType = .Unknown
    /// 如果是模拟器，那么返回Simulator
    @objc var type:DeviceType {
        get {
            return _type
        }
    }
    
    private var _hardwareLevel:DeviceHardwareLevel = .Medium
    /// 如果是模拟器，那么返回Low
    @objc var hardwareLevel:DeviceHardwareLevel {
        get {
            return _hardwareLevel
        }
    }
    
    
    public override init() {
        super.init()
        _type = getType()
        _hardwareLevel = getHardwareLevel()
    }
    
    private func getHardwareLevel() -> DeviceHardwareLevel {
        switch type.rawValue {
        case ..<DeviceType.IPhone_7.rawValue:
            return .Low
        case DeviceType.IPhone_7.rawValue..<DeviceType.IPhone_X.rawValue:
            return .Medium
        default:
            return .High
        }
    }
    
    private func getType() -> DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        //下面几行代码大概意思是把systemInfo.machine的数据转位String格式
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
           guard let value = element.value as? Int8, value != 0 else { return identifier }
           return identifier + String(UnicodeScalar(UInt8(value)))
        }
//        UIDevice.current.name;
        let t:DeviceType
        switch identifier {
        case "i386":
            t = .Simulator
        case "x86_64":
            t = .Simulator
        case "iPhone1,1":
            t = .IPhone_1G
        case "iPhone1,2":
            t = .IPhone_3G
        case "iPhone2,1":
            t = .IPhone_3GS
        case "iPhone3,1":
            t = .IPhone_4
        case "iPhone3,2":
            t = .IPhone_4
        case "iPhone4,1":
            t = .IPhone_4s
        case "iPhone5,1":
            t = .IPhone_5
        case "iPhone5,2":
            t = .IPhone_5
        case "iPhone5,3":
            t = .IPhone_5C
        case "iPhone5,4":
            t = .IPhone_5C
        case "iPhone6,1":
            t = .IPhone_5S
        case "iPhone6,2":
            t = .IPhone_5S
        case "iPhone7,1":
            t = .IPhone_6P
        case "iPhone7,2":
            t = .IPhone_6
        case "iPhone8,1":
            t = .IPhone_6s
        case "iPhone8,2":
            t = .IPhone_6s_P
        case "iPhone8,4":
            t = .IPhone_SE1
        case "iPhone9,1":
            t = .IPhone_7
        case "iPhone9,2":
            t = .IPhone_7P
        case "iPhone9,3":
            t = .IPhone_7
        case "iPhone9,4":
            t = .IPhone_7P
        case "iPhone10,1":
            t = .IPhone_8
        case "iPhone10,2":
            t = .IPhone_8P
        case "iPhone10,3":
            t = .IPhone_X
        case "iPhone10,4":
            t = .IPhone_8
        case "iPhone10,5":
            t = .IPhone_8P
        case "iPhone10,6":
            t = .IPhone_X
        case "iPhone11,2":
            t = .iPhone_XS
        case "iPhone11,4":
            t = .iPhone_XS_Max
        case "iPhone11,6":
            t = .iPhone_XS_Max
        case "iPhone11,8":
            t = .iPhone_XR
        default:
            t = .Unknown
    }
        return t
    }
}
