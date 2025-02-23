//
//  ScheduleCollectionView.swift
//  CyxbsWidgetExtension
//
//  Created by SSR on 2023/9/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import SwiftUI

struct ScheduleCollectionView: View {
    
    let title: String
    
    let content: String
    
    let drawType: ScheduleDrawType.CurriculumType
    
    let showMuti: Bool
    
    let isTitleOnly: Bool
    
    var body: some View {
        
        ZStack {
            
            if (drawType == .custom) {
                
                Image("lineline")
                    .resizable(resizingMode: .tile)
            } else {
                
                Color(drawType.backgroundColor)
            }
            
            if isTitleOnly {
                
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(Color(drawType.textColor))
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, horizontalPadding)
            } else {
                
                VStack {
                    
                    Text(title)
                        .font(.system(size: 10))
                        .foregroundColor(Color(drawType.textColor))
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, topBottomMargin)
                    
                    Spacer()
                    
                    Text(content)
                        .font(.system(size: 10))
                        .foregroundColor(Color(drawType.textColor))
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.bottom, topBottomMargin)
                }
            }
            
            if showMuti {
                
                GeometryReader { entry in
                    
                    HStack {
                        
                        Spacer()
                        
                        Capsule(style: .continuous)
                            .foregroundColor(Color(drawType.textColor))
                            .frame(width: 8, height: 2)
                            .padding(.top, topBottomMargin / 2)
                            .padding(.trailing, horizontalPadding / 2)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
    }
}

extension ScheduleCollectionView {
    
    var horizontalPadding: CGFloat { 5 }
    
    var topBottomMargin: CGFloat { 6 }
}
