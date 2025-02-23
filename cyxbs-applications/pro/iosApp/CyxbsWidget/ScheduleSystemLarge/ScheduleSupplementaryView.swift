//
//  ScheduleSupplementaryView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import SwiftUI

struct ScheduleSupplementaryView: View {
    
    let title: String
    
    let content: String
    
    let drawType: ScheduleDrawType.SupplementaryType
    
    let isTitleOnly: Bool
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .foregroundColor(Color(drawType.backgroundColor))
            
            VStack {
                
                if isTitleOnly {
                    
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 10))
                        .foregroundColor(Color(drawType.titleTextColor))
                    
                } else {
                    
                    Text(title)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 10))
                        .padding(.horizontal, 7)
                        .lineLimit(3)
                        .foregroundColor(Color(drawType.titleTextColor))
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    Text(content)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 10))
                        .padding(.horizontal, 7)
                        .lineLimit(3)
                        .foregroundColor(Color(drawType.titleTextColor))
                        .padding(.bottom, 8)
                }
            }
        }
    }
}
