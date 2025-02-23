//
//  AddArrangeFlowLayout.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class AddArrangeFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let answer = super.layoutAttributesForElements(in: rect)
        for (index,value) in (answer?.enumerated())! {
            if index > 0 {
                let currentLayoutAttributes: UICollectionViewLayoutAttributes = value
                let prevLayoutAttributes: UICollectionViewLayoutAttributes = answer![index - 1]
                let maximumSpacing = 5.75
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + CGFloat(maximumSpacing) + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                    var frame = currentLayoutAttributes.frame
                    frame.origin.x = origin + CGFloat(maximumSpacing)
                    currentLayoutAttributes.frame = frame
                }
            }
        }
        return answer
    }
}
