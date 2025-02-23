//
//  TodoTitleInputTextField.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

class TodoTitleInputTextField: UITextField {

    private let offset: CGFloat = 0.04533333333 * SCREEN_WIDTH

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.layer.cornerRadius = 22
        self.backgroundColor = UIColor.ry(light: "#E8F1FC", dark: "#1F1F1F")
        self.textColor = UIColor.ry(light: "#15315B", dark: "#F0F0F2")
        self.font = UIFont(name: "PingFangSC-Medium", size: 15)
        // 创建一个带有自定义颜色的属性字符串
        let placeholderText = "添加待办事项"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.ry(light: "#15315B", dark: "#FFFFFF").withAlphaComponent(0.52) // 设置 placeholder 的颜色
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        // 设置 UITextField 的 placeholder
        self.attributedPlaceholder = attributedPlaceholder
    }

    /// 重写后可以改变非编辑状态时光标的位置
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: offset, dy: 0)
    }

    /// 重写后可以改变编辑时光标的位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: offset, dy: 0)
    }
}

