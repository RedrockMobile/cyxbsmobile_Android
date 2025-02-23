//
//  DLTimeSelectedButton.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

// 定义协议
protocol DLTimeSelectedButtonDelegate: AnyObject {
    func deleteButton(with button: DLTimeSelectedButton)
}

// 继承自 DLHistodyButton
class DLTimeSelectedButton: DLHistodyButton {
    
    // 定义委托
    weak var delegate: DLTimeSelectedButtonDelegate?
    
    // 删除按钮
    private var deleteBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addDeleteBtn()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        addDeleteBtn()
    }
    
    private func setupButton() {
        self.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 15)
        self.layer.masksToBounds = false
        
        // 使用 SnapKit 设置 titleLabel 的约束
        self.titleLabel?.snp.makeConstraints { make in
            make.left.equalTo(self).offset(SCREEN_WIDTH * 0.053333333333333)
            make.right.equalTo(self).offset(-SCREEN_WIDTH * 0.053333333333333)
        }
    }
    
    private func addDeleteBtn() {
        let btn = UIButton()
        self.addSubview(btn)
        self.deleteBtn = btn
        
        btn.setBackgroundImage(UIImage(named: "reminderDeleteImage"), for: .normal)
        btn.layer.cornerRadius = 8.5 * kRateX
        btn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        // 使用 SnapKit 设置 deleteBtn 的约束
        btn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.width.height.equalTo(17 * kRateX)
        }
    }
    
    @objc private func deleteBtnClicked() {
        if let delegate = delegate {
            delegate.deleteButton(with: self)
        }
    }
}

