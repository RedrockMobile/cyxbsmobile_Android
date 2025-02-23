//
//  ToDoTopNoDeadlineStyleCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/28.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

/// 复用标志
let ToDoTopNoDeadlineStyleCellForFinderReuseIdentifier = "ToDoTopNoDeadlineStyleCellForFinder"

// 置顶+无时间样式的cell
class ToDoTopNoDeadlineStyleCellForFinder: ToDoTableViewCellForFinder {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLab)
        contentView.addSubview(button)
        backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F6F7FF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 15, y: 11, width: 17, height: 17)
        contentLab.frame = CGRect(x: button.right + 12, y: 7, width: self.width - button.right - 12, height: 25)
    }
    
    // MARK: - Method
    
    private func configCell() {
        button.setBackgroundImage(UIImage(named: "未完成圆圈"), for: .normal)
        contentLab.textColor = UIColor(.dm, light: UIColor(hexString: "#4A44E4", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
    }
}
