//
//  UIButton+Cyxbs.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIButton {
    
    var gradientLayer: CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.colors = [
            UIColor.hex("#4841E2").cgColor,
            UIColor.hex("#5D5DF7").cgColor
        ]
        layer.locations = [0, 1]
        return layer
    }
    
    convenience init(gradientLayerSize size: CGSize, title: String?) {
        self.init(frame: CGRect(origin: .zero, size: size))
        layer.addSublayer(gradientLayer)
        layer.cornerRadius = size.height / 2
        clipsToBounds = true
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
    }
}
