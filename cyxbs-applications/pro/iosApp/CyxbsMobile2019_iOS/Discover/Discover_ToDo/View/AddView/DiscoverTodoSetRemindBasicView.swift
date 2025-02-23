//
//  DiscoverTodoSetRemindBasicView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/19.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

class DiscoverTodoSetRemindBasicView: UIView {
    
    // 紫色三角形
    lazy var tipView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "todo紫色提醒图标")
        return view
    }()
    
    // 取消按钮
    lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.layer.cornerRadius = 0.0533333333 * SCREEN_WIDTH
        button.backgroundColor = UIColor.ry(light: "#EDF4FD", dark: "#484A4D")
        button.titleLabel?.font = UIFont(name: "PingFangSCSemibold", size: 18)
        button.setTitleColor(UIColor.ry(light: "#7CA3DF", dark: "#F0F0F2"), for: .normal)
        return button
    }()
    
    // 确定按钮
    lazy var sureBtn: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.layer.cornerRadius = 0.0533333333 * SCREEN_WIDTH
        button.backgroundColor = UIColor.ry(light: "#4841E2", dark: "#4841E2")
        button.titleLabel?.font = UIFont(name: "PingFangSCSemibold", size: 18)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(light: UIColor(hexString: "#EDF4FD",alpha: 0.6), dark: UIColor(hexString: "#F8F9FC", alpha: 0.1))
        return view
    }()
    
    // 1代表状态为show，0为hide，子类自己去维护，父类不维护
    var isViewHided: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.ry(light: "#FFFFFF", dark: "#2C2C2C")
        self.isViewHided = true
        self.alpha = 0
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化UI：
    
    private func setupViews() {
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
        addSubview(tipView)
        tipView.snp.makeConstraints { make in
            make.width.equalTo(0.016 * SCREEN_WIDTH)
            make.height.equalTo(0.02057142857 * SCREEN_WIDTH)
        }
        addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(0.128 * SCREEN_WIDTH)
            make.bottom.equalTo(self).offset(-0.04926108374 * SCREEN_HEIGHT)
            make.width.equalTo(0.32 * SCREEN_WIDTH)
            make.height.equalTo(0.1066666667 * SCREEN_WIDTH)
        }
        self.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-0.128 * SCREEN_WIDTH)
            make.bottom.equalTo(self).offset(-0.04926108374 * SCREEN_HEIGHT)
            make.width.equalTo(0.32 * SCREEN_WIDTH)
            make.height.equalTo(0.1066666667 * SCREEN_WIDTH)
        }
    }
    
    func showView() {
        // 子类实现
    }
    
    func hideView() {
        // 子类实现
    }
}

