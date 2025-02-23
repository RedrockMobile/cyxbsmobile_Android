//
//  ToDoNonTopExpiredStyleCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/28.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

/// 复用标志
let ToDoNonTopExpiredStyleCellForFinderReuseIdentifier = "ToDoNonTopExpiredStyleCellForFinder"

// 非置顶+过期样式的cell
class ToDoNonTopExpiredStyleCellForFinder: ToDoTableViewCellForFinder {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLab)
        contentView.addSubview(timeLab)
        contentView.addSubview(button)
        contentView.addSubview(bellImgView)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 15, y: 11, width: 17, height: 17)
        contentLab.frame = CGRect(x: button.right + 12, y: 7, width: self.width - button.right - 12, height: 25)
        bellImgView.frame = CGRect(x: contentLab.left, y: contentLab.bottom + 4, width: 11, height: 13)
        timeLab.frame = CGRect(x: bellImgView.right + 8, y: contentLab.bottom, width: self.right - bellImgView.right - 8, height: 15.4)
    }
    
    // MARK: - Method
    
    private func configCell() {
        button.setBackgroundImage(UIImage(named: "ToDo过期圆圈"), for: .normal)
        contentLab.textColor = UIColor(.dm, light: UIColor(hexString: "#FF6262", alpha: 1), dark: UIColor(hexString: "#FF6262", alpha: 1))
        timeLab.textColor = UIColor(.dm, light: UIColor(hexString: "#77729A", alpha: 1), dark: UIColor(hexString: "#9C9C9D", alpha: 1))
        bellImgView.image = UIImage(named: "todo已过期铃铛")
    }
}
