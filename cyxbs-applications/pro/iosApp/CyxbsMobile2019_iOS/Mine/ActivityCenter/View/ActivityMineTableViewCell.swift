//
//  ActivityMineTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityMineTableViewCell: UITableViewCell {
    
    lazy var coverImgView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(16, 16, 101, 101))
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.067, green: 0.173, blue: 0.329, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let clockImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRectMake(128, 102, 16, 16)
        imgView.image = UIImage(named: "activityTime")
        return imgView
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(149, 101, 94, 17)
        label.textAlignment = .left
        label.font = UIFont(name: PingFangSCMedium, size: 12)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.973, green: 0.976, blue: 0.988, alpha: 1)
        contentView.addSubview(coverImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(clockImgView)
        contentView.addSubview(startTimeLabel)
        // 使用Auto Layout设置UILabel的约束
        setPosition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition() {
        //titleLabel位置设定
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 127).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        //detailLabel位置设置
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 127).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
    }
}
