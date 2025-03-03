//
//  ToDoNonTopNoDeadlineStyleCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/28.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

/// 复用标志
let ToDoNonTopNoDeadlineStyleCellReuseIdentifier = "ToDoNonTopNoDeadlineStyleCell"

// 非置顶+无时间样式的cell
class ToDoNonTopNoDeadlineStyleCell: ToDoTableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLab)
        contentView.addSubview(button)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 15, y: 13, width: 23, height: 23)
        contentLab.frame = CGRect(x: button.right + 12, y: 12, width: self.width - button.right - 12, height: 25)
    }
    
    // MARK: - Method
    
    private func configCell() {
        button.setBackgroundImage(UIImage(named: "未完成圆圈"), for: .normal)
        contentLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
    }
}
