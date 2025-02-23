//
//  ActivityCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageCell"
    // 标记 Cell 是否是新显示的的
    var isNewlyLayout: Bool = true
    
    let coverImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width - 41) / 2, height: 145)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(12, 158, 82, 22)
        label.textAlignment = .left
        label.font = UIFont(name: PingFangSCSemibold, size: 16)
        label.textColor = UIColor(hexString: "#15315B")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityTypeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(12, 182, 48, 17)
        label.textAlignment = .left
        label.font = UIFont(name: PingFangSCMedium, size: 12)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRectMake(33, 207, 94, 17)
        label.textAlignment = .left
        label.font = UIFont(name: PingFangSCMedium, size: 12)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let clockImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRectMake(12, 208, 16, 16)
        imgView.image = UIImage(named: "activityTime")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(coverImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(activityTypeLabel)
        contentView.addSubview(startTimeLabel)
        contentView.addSubview(clockImgView)
        //设置阴影
        layer.shadowColor = UIColor(hexString: "#918BCE", alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.white.cgColor
        //设置圆角
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isNewlyLayout {
            // 添加渐入动画效果，仅对新加载的 Cell 生效
            // 初始时设置 Cell 的透明度为 0
            self.alpha = 0.0
            isNewlyLayout = false
        }
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
        // 在布局发生变化时更新阴影路径
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}




