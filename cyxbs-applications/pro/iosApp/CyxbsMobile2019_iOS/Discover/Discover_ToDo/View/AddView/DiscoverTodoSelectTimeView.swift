//
//  DiscoverTodoSelectTimeView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

protocol DiscoverTodoSelectTimeViewDelegate: AnyObject {
    func selectTimeViewSureBtnClicked(date: Date)
    func selectTimeViewCancelBtnClicked()
}

class DiscoverTodoSelectTimeView: DiscoverTodoSetRemindBasicView {
    
    weak var delegate: DiscoverTodoSelectTimeViewDelegate?
    
    var selectedDate: Date = Date() {
        didSet {
            datePicker.date = selectedDate
        }
    }
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        // 本地化设置为中国，24小时制
        datePicker.locale = Locale(identifier: "zh_CHT")
        datePicker.date = selectedDate
        // iOS 13.4 之后设置成滑轮样式
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        // 设置成本地时区
        datePicker.timeZone = .current
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(datePicker)
        setupConstraints()
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        cancelBtn.setTitle("上一步", for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 为紫色的tipView布局
    private func setupConstraints() {
        tipView.snp.makeConstraints { make in
            make.centerY.equalTo(datePicker)
            make.right.equalTo(datePicker.snp.left)
        }
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(0.059408867 * SCREEN_HEIGHT)
            make.bottom.equalTo(self).offset(-0.1477832512 * SCREEN_HEIGHT)
        }
    }
    
    /// 下方的取消按钮点击后调用
    @objc private func cancelBtnClicked() {
        hideView()
        delegate?.selectTimeViewCancelBtnClicked()
    }
    
    /// 下方的确定按钮点击后调用
    @objc private func sureBtnClicked() {
        hideView()
        delegate?.selectTimeViewSureBtnClicked(date: datePicker.date)
    }
    
    /// 外界调用，调用后显示出来
    override func showView() {
        print("\(isViewHided), \(self.alpha)")
        if isViewHided == true {
            isViewHided = false
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    /// 调用后效果如同点击取消按钮，但是不会调用代理方法
    override func hideView() {
        if isViewHided == false {
            isViewHided = true
            UIView.animate(withDuration: 0.5) {
                self.alpha = 0
            }
        }
    }
}

