//
//  GradientButton.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/10/31.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class GradientButton: UIButton {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    func setupGradient() {
        backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.colors = [
            UIColor(red: 0.282, green: 0.255, blue: 0.886, alpha: 1).cgColor,
            UIColor(red: 0.365, green: 0.365, blue: 0.969, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.clipsToBounds = true
        if let oldGradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradientBackground() {
        if let oldGradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
    }
}
