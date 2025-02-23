//
//  ActivitySelectBar.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/14.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivitySelectBar: UIView {
    var buttons: [RadioButton] = []
    var selectedCategory: String = "all" {
        didSet {
            print("Selected Category: \(selectedCategory)")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupButtons()
        selectedCategory = "all" // 默认设置为 "all"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        setupButtons()
        selectedCategory = "all" // 默认设置为 "all"
    }

    private func setupButtons() {
        let titles = ["全部", "文娱活动", "体育活动", "教育活动"]

        for (index, title) in titles.enumerated() {
            let button = RadioButton()
            button.setTitle(title, for: .normal)
            button.tag = index // Set tag to identify the button
            button.addTarget(self, action: #selector(handleRadioButtonTap(_:)), for: .touchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        buttons[0].isSelected = true
        buttons[0].applyGradientBackground()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var totalButtonWidth: CGFloat = 0
        for button in buttons {
            if let title = button.titleLabel?.text {
                let titleWidth = title.size(withAttributes: [NSAttributedString.Key.font: button.titleLabel?.font as Any]).width
                totalButtonWidth += titleWidth + 28
            }
        }

        let spacing: CGFloat = (bounds.width - totalButtonWidth) / CGFloat(buttons.count + 1)

        var xOffset: CGFloat = spacing

        for button in buttons {
            if let title = button.titleLabel?.text {
                let titleWidth = title.size(withAttributes: [NSAttributedString.Key.font: button.titleLabel?.font as Any]).width
                let buttonWidth = titleWidth + 28
                let buttonHeight: CGFloat = 30
                
                button.frame = CGRect(x: xOffset, y: (bounds.height - buttonHeight), width: buttonWidth, height: buttonHeight)
                xOffset += buttonWidth + spacing
            }
        }
        buttons[0].applyGradientBackground()
    }


    @objc private func handleRadioButtonTap(_ sender: RadioButton) {
        for button in buttons {
            button.isSelected = (button == sender)
        }

        switch sender.tag {
        case 0:
            selectedCategory = "all"
        case 1:
            selectedCategory = "culture"
        case 2:
            selectedCategory = "sports"
        case 3:
            selectedCategory = "education"
        default:
            break
        }
    }
}

class RadioButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if (isSelected){
                applyGradientBackground()
            }
            else{
                applyNormalBackground()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setTitleColor(UIColor(hexString: "#2A4E84", alpha: 0.5), for: .normal)
        setTitleColor(UIColor(hexString: "#4F4AE9", alpha: 1), for: .selected)
        backgroundColor = UIColor(hexString: "#5F7AA2", alpha: 0.05)
        titleLabel?.font = UIFont(name: PingFangSCMedium, size: 14)
        layer.cornerRadius = 15 // 调整圆角的大小
    }
    
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 15
        
        let startColor: UIColor
        let endColor: UIColor
        
        startColor = UIColor(hexString: "#4841E2", alpha: 0.1)
        endColor = UIColor(hexString: "#5D5DF7", alpha: 0.1)
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        if let oldGradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }

        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyNormalBackground() {
        if let oldGradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            oldGradientLayer.removeFromSuperlayer()
        }
    }
    
}






