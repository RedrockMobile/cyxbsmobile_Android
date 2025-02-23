//
//  DiscoverTodoSelectTypeView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/27.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

protocol DiscoverTodoSelectTypeViewDelegate: AnyObject {
    func selectTypeViewSureBtnClicked(_ type: ToDoType)
    func selectTypeViewCancelBtnClicked()
}

class DiscoverTodoSelectTypeView: DiscoverTodoSetRemindBasicView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    weak var delegate: DiscoverTodoSelectTypeViewDelegate?
    /// 数据选择器
    private var pickerView: UIPickerView!
    /// 选中的类型
    private var selectedType: ToDoType = .study {
        didSet {
            pickerView.selectRow(Int(selectedType.rawValue), inComponent: 0, animated: false)
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        addPickerView()
        layoutTipView()
        
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
    }
    
    private func addPickerView() {
        pickerView = UIPickerView()
        addSubview(pickerView)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(0.039 * SCREEN_HEIGHT)
            make.bottom.equalTo(self).offset(-0.147 * SCREEN_HEIGHT)
        }
    }
    
    private func layoutTipView() {
        tipView.snp.makeConstraints { make in
            make.centerY.equalTo(pickerView)
            make.right.equalTo(pickerView.snp.left)
        }
    }
    
    // MARK: - UIPickerViewDataSource & UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ["学习", "生活", "其他"][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = ToDoType(rawValue: UInt(row)) ?? .other
    }
    
    // MARK: - Button Actions
    @objc private func cancelBtnClicked() {
        hideView()
        delegate?.selectTypeViewCancelBtnClicked()
    }
    
    @objc private func sureBtnClicked() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
        
        isViewHided = true
        delegate?.selectTypeViewSureBtnClicked(selectedType)
    }
    
    /// 外界调用，调用后显示出来
    override func showView() {
        if isViewHided {
            isViewHided = false
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
                for subView in self.subviews {
                    subView.alpha = 1
                }
            }
        }
    }

    /// 调用后效果如同点击取消按钮，但是不会调用代理方法
    override func hideView() {
        if !isViewHided {
            isViewHided = true
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0
            }
        }
    }
}
