//
//  ArrangeMessageTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

/// 复用标志
let ArrangeMessageTableViewCellReuseIdentifier = "ArrangeMessageTableViewCell"

class ArrangeMessageTableViewCell: UITableViewCell {
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLab)
        contentView.addSubview(statusImgView)
        contentView.addSubview(contentLab)
        contentView.addSubview(timeLab)
        contentView.addSubview(button)
        contentView.backgroundColor = .white
        
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLab.frame = CGRect(x: 17, y: 17, width: 70, height: 24)
        statusImgView.frame = CGRect(x: self.width - 17 - 50, y: titleLab.top + 2, width: 50, height: 20)
        
        contentLab.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(47)
            make.right.equalTo(self.snp.right).inset(titleLab.left)
        }
        
        timeLab.frame = CGRect(x: titleLab.left, y: contentLab.bottom + 5, width: 92, height: 16)
        button.frame = CGRect(x: (self.width - 98) / 2, y: self.height - 15 - 22, width: 98, height: 22)
    }
    
    // MARK: - Lazy
    
    /// '活动通知'/'取消通知'文本
    lazy var titleLab: UILabel = {
        let titleLab = UILabel()
        titleLab.font = .boldSystemFont(ofSize: 17)
        return titleLab
    }()
    /// '未开始'/'已结束'视图
    lazy var statusImgView: UIImageView = {
        let statusImgView = UIImageView()
        return statusImgView
    }()
    /// 消息内容文本
    lazy var contentLab: UILabel = {
        let contentLab = UILabel()
        contentLab.font = .boldSystemFont(ofSize: 14)
        contentLab.numberOfLines = 0
        return contentLab
    }()
    /// 时间文本
    lazy var timeLab: UILabel = {
        let timeLab = UILabel()
        timeLab.font = .boldSystemFont(ofSize: 14)
        return timeLab
    }()
    /// 最底部的按钮
    lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
}
