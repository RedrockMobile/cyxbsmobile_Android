//
//  ToDoBatchManageBottomView.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/22.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

protocol ToDoBatchManageBottomViewDelegate: AnyObject {
    func checkAllToDo(isSelected: Bool)
    func stickyToDos()
    func deleteToDos()
}

// 点击批量管理后todo主页的底部视图
class ToDoBatchManageBottomView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ToDoBatchManageBottomViewDelegate?

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkBoxBtn)
        addSubview(label)
        addSubview(stickyBtn)
        addSubview(deleteBtn)
        self.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkBoxBtn.frame = CGRect(x: 15, y: 23, width: 23, height: 23)
        label.frame = CGRect(x: checkBoxBtn.right + 12, y: 22, width: 37, height: 25)
        stickyBtn.frame = CGRect(x: self.width - 124 - 100, y: 16, width: 100, height: 37)
        deleteBtn.frame = CGRect(x: stickyBtn.right + 9, y: stickyBtn.top, width: stickyBtn.width, height: stickyBtn.height)
    }
    
    // MARK: - Method
    
    @objc private func clickCheckBoxBtn() {
        checkBoxBtn.isSelected = !checkBoxBtn.isSelected
        delegate?.checkAllToDo(isSelected: checkBoxBtn.isSelected)
    }
    
    @objc private func clickStickyBtn() {
        delegate?.stickyToDos()
    }
    
    @objc private func clickDeleteBtn() {
        delegate?.deleteToDos()
    }
    
    // MARK: - Lazy
    
    /// 全选的勾选框按钮
    lazy var checkBoxBtn: UIButton = {
        let checkBoxBtn = UIButton()
        checkBoxBtn.setBackgroundImage(UIImage(named: "todo方框"), for: .normal)
        checkBoxBtn.setBackgroundImage(UIImage(named: "todo方框_已选中"), for: .selected)
        checkBoxBtn.addTarget(self, action: #selector(clickCheckBoxBtn), for: .touchUpInside)
        return checkBoxBtn
    }()
    /// '全选'文本
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "全选"
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#FFFFFF", alpha: 1))
        return label
    }()
    /// 置顶按钮
    private lazy var stickyBtn: UIButton = {
        let stickyBtn = UIButton()
        stickyBtn.setTitle("置顶", for: .normal)
        stickyBtn.titleLabel?.font = .systemFont(ofSize: 14)
        stickyBtn.setImage(UIImage(named: "置顶"), for: .normal)
        stickyBtn.layer.cornerRadius = 19
        stickyBtn.clipsToBounds = true
        stickyBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
//        stickyBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        stickyBtn.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#5263FF", alpha: 1), dark: UIColor(hexString: "#5263FF", alpha: 1))
        stickyBtn.addTarget(self, action: #selector(clickStickyBtn), for: .touchUpInside)
        return stickyBtn
    }()
    /// 删除按钮
    private lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton()
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.titleLabel?.font = .systemFont(ofSize: 14)
        deleteBtn.setImage(UIImage(named: "todo删除"), for: .normal)
        deleteBtn.layer.cornerRadius = 19
        deleteBtn.clipsToBounds = true
        deleteBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
        deleteBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        deleteBtn.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FF6262", alpha: 1), dark: UIColor(hexString: "#FF6262", alpha: 1))
        deleteBtn.addTarget(self, action: #selector(clickDeleteBtn), for: .touchUpInside)
        return deleteBtn
    }()
}
