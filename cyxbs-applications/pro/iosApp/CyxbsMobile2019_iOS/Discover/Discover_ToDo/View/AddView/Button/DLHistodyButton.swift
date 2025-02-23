//
//  DLHistodyButton.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

class DLHistodyButton: UIButton {
    
    // 以 iPhoneX 为基准的比例
    let kRateX = SCREEN_WIDTH / 375.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        self.backgroundColor = UIColor.ry(light: "#F2F3F7", dark: "#5E5E5E")
        self.layer.cornerRadius = 15 * kRateX
        self.layer.masksToBounds = true
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 13)
        self.setTitleColor(UIColor.ry(light: "#14305B", dark: "#EFEFF1"), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.height / 2.0
    }
}

