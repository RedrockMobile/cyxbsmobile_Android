//
//  BaseButton.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    var imageViewSize: CGSize = .zero
    
    var imagePostion: ImagePosition? = nil
    
    var spaceForMiddle: CGFloat = 0
    
    enum ImagePosition {
        
        case top        // image 上，label 下
        
        case left       // image 左，label 右
        
        case bottom     // image 下，label 上
        
        case right      // image 右，label 左
    }

    func set(imageViewSize: CGSize, imagePostion: ImagePosition?, spaceForMiddle: CGFloat) {
        self.imageViewSize = imageViewSize
        self.imagePostion = imagePostion
        self.spaceForMiddle = spaceForMiddle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let imagePostion else { return }
        
        imageView?.frame.size = imageViewSize
        guard let imgFrame = imageView?.frame, let titleFrame = titleLabel?.frame else { return }
        
        switch imagePostion {
        case .top:
            let spaceForY = (bounds.height - imgFrame.height - titleFrame.height - spaceForMiddle) / 2
            let spaceForImgX = (bounds.width - imgFrame.width) / 2
            let spaceForTilX = (bounds.width - titleFrame.width) / 2
            imageView?.frame.origin = CGPoint(x: spaceForImgX, y: spaceForY)
            titleLabel?.frame.origin = CGPoint(x: spaceForTilX, y: spaceForY + imgFrame.height + spaceForMiddle)
            
        case .left:
            let spaceForX = (bounds.width - imgFrame.width - titleFrame.width - spaceForMiddle) / 2
            let spaceForImgY = (bounds.height - imgFrame.height) / 2
            let spaceForTilY = (bounds.height - titleFrame.height) / 2
            imageView?.frame.origin = CGPoint(x: spaceForX, y: spaceForImgY)
            titleLabel?.frame.origin = CGPoint(x: spaceForX + imgFrame.width + spaceForMiddle, y: spaceForTilY)
            
        case .bottom:
            let spaceForY = (bounds.height - imgFrame.height - titleFrame.height - spaceForMiddle) / 2
            let spaceForTilX = (bounds.width - titleFrame.width) / 2
            let spaceForImgX = (bounds.width - imgFrame.width) / 2
            titleLabel?.frame.origin = CGPoint(x: spaceForTilX, y: spaceForY)
            imageView?.frame.origin = CGPoint(x: spaceForImgX, y: spaceForY + titleFrame.height + spaceForMiddle)
            
        case .right:
            let spaceForX = (bounds.width - imgFrame.width - titleFrame.width - spaceForMiddle) / 2
            let spaceForTilY = (bounds.height - titleFrame.height) / 2
            let spaceForImgY = (bounds.height - imgFrame.height) / 2
            titleLabel?.frame.origin = CGPoint(x: spaceForX, y: spaceForTilY)
            imageView?.frame.origin = CGPoint(x: spaceForX + titleFrame.width + spaceForMiddle, y: spaceForImgY)
        }
    }
}
