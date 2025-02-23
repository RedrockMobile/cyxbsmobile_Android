//
//  ToDoTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/19.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

protocol ToDoTableViewCellDelegate: AnyObject {
    func clickToDoCircleBtn(sender: UIButton)
}

class ToDoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: ToDoTableViewCellDelegate?

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    @objc private func clickButton() {
        button.isSelected = !button.isSelected
        delegate?.clickToDoCircleBtn(sender: button)
    }
    
    // MARK: - Lazy
    
    /// 最左边的按钮
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    /// 内容文本
    lazy var contentLab: UILabel = {
        let contentLab = UILabel()
        contentLab.font = .systemFont(ofSize: 18)
        return contentLab
    }()
    /// 时间文本
    lazy var timeLab: UILabel = {
        let timeLab = UILabel()
        timeLab.font = .systemFont(ofSize: 13)
        return timeLab
    }()
    /// 铃铛图片
    lazy var bellImgView: UIImageView = {
        let bellImgView = UIImageView()
        return bellImgView
    }()
}
