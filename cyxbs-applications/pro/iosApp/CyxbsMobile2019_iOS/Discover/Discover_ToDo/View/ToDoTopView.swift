//
//  ToDoTopView.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/13.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

protocol ToDoTopViewDelegate: AnyObject {
    func popVC()
    func batchManage(isSelected: Bool)
}

// 邮子清单主页顶部视图
class ToDoTopView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ToDoTopViewDelegate?
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(label)
        addSubview(manageBtn)
        self.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backBtn.frame = CGRect(x: 16, y: 16, width: 7, height: 16)
        label.frame = CGRect(x: backBtn.right + 13, y: 9, width: 90, height: 31)
        manageBtn.frame = CGRect(x: SCREEN_WIDTH - 16 - 85, y: 13, width: 85, height: 23)
    }
    
    // MARK: - Method
    
    @objc private func clickBackBtn() {
        delegate?.popVC()
    }
    
    @objc private func clickManageBtn() {
        manageBtn.isSelected = !manageBtn.isSelected
        delegate?.batchManage(isSelected: manageBtn.isSelected)
    }
    
    // MARK: - Lazy
    
    /// 返回按钮
    private lazy var backBtn: MXBackButton = {
        let backBtn = MXBackButton(frame: .zero, isAutoHotspotExpand: true)
        backBtn.setImage(UIImage(named: "todo返回按钮"), for: .normal)
        backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
        return backBtn
    }()
    /// '邮子清单'文本
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "邮子清单"
        label.font = .systemFont(ofSize: 22, weight: .black)
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#DFDFE3", alpha: 1))
        return label
    }()
    /// 批量添加按钮
    lazy var manageBtn: UIButton = {
        let manageBtn = UIButton()
        manageBtn.setImage(UIImage(named: "todo批量添加"), for: .normal)
        manageBtn.setImage(UIImage(named: "todo退出批量管理"), for: .selected)
        manageBtn.addTarget(self, action: #selector(clickManageBtn), for: .touchUpInside)
        return manageBtn
    }()
}
