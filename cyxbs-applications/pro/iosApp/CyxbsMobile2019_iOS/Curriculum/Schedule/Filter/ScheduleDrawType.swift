//
//  ScheduleDrawType.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

enum ScheduleDrawType: Hashable {
    
    enum CurriculumType: Hashable {
        
        case morning
        
        case afternoon
        
        case night
        
        case others
        
        case custom
    }
    
    enum SupplementaryType: Hashable {
        
        case normal
        
        case select
    }
    
    case curriculum(CurriculumType)
    
    case supplementary(SupplementaryType)
}

extension ScheduleDrawType.CurriculumType {
    
    var backgroundColor: UIColor {
        switch self {
        case .morning:
            return .ry(light: "#F9E7D8", dark: "#FFCCA126")
        case .afternoon:
            return .ry(light: "#F9E3E4", dark: "#FF979B26")
        case .night:
            return .ry(light: "#DDE3F8", dark: "#9BB2FB26")
        case .others:
            return .ry(light: "#DFF3FC", dark: "#90DBFB26")
        case .custom:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .morning:
            return .ry(light: "#FF8015", dark: "#F0F0F2CC")
        case .afternoon:
            return .ry(light: "#FF6262", dark: "#F0F0F2CC")
        case .night:
            return .ry(light: "#4066EA", dark: "#F0F0F2CC")
        case .others:
            return .ry(light: "#06A3FC", dark: "#F0F0F2CC")
        case .custom:
            return .label
        }
    }
}

extension ScheduleDrawType.SupplementaryType {
    
    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return .clear
        case .select:
            return .ry(light: "#2A4E84", dark: "#5A5A5ACC")
        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .normal:
            return .ry(light: "#15315B", dark: "#F0F0F2")
        case .select:
            return .ry(light: "#FFFFFF", dark: "#F0F0F2")
        }
    }
    
    var contentTextColor: UIColor {
        switch self {
        case .normal:
            return .ry(light: "#606E8A", dark: "#868686")
        case .select:
            return .ry(light: "#FFFFFF64", dark: "#868686")
        }
    }
}
