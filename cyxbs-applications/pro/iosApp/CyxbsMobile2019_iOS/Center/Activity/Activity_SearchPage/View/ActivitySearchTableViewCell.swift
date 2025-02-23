//
//  ActivitySearchTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivitySearchTableViewCell: UITableViewCell {
    
    lazy var coverImgView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(16, 16, 101, 101))
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
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
    
    lazy var statusImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.size = CGSize(width: 32, height: 14)
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let clockImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRectMake(135, 97, 16, 16)
        imgView.image = UIImage(named: "activityTime")
        return imgView
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(155, 96, 94, 17)
        label.textAlignment = .left
        label.font = UIFont(name: PingFangSCMedium, size: 12)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(coverImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(clockImgView)
        contentView.addSubview(startTimeLabel)
        contentView.addSubview(statusImgView)
        // 使用Auto Layout设置UILabel的约束
        setPosition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition() {
        //titleLabel位置设定
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 134).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 162).isActive = true
        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 19).isActive = true
        //detailLabel位置设置
        detailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 134).isActive = true
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 176).isActive = true
        detailLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        //statusImgView位置
        statusImgView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 4).isActive = true
        statusImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21).isActive = true
    }
}




