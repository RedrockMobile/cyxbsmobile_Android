//
//  ActivityReviewedTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/23.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityReviewedTableViewCell: UITableViewCell {
    
    var activityId: Int = 0
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.size = CGSize(width: 75, height: 20)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let creatorView: TitleContentView = {
        let view = TitleContentView()
        view.frame = CGRectMake(21, 55, 126, 20)
        view.titleLabel.text = "创建人:"
        return view
    }()
    
    let phoneView: TitleContentView = {
        let view = TitleContentView()
        view.frame = CGRectMake(21, 77, 126, 20)
        view.titleLabel.text = "联系电话:"
        return view
    }()
    
    let statusView : UIImageView = {
        let imgView = UIImageView()
        imgView.size = CGSize(width: 52, height: 21)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.973, green: 0.976, blue: 0.988, alpha: 1)
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(startTimeLabel)
        cardView.addSubview(creatorView)
        cardView.addSubview(phoneView)
        cardView.addSubview(statusView)
        setPosition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition() {
        //cardView位置设定
        cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        //titleLabel位置设定
        titleLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 21).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //startTimeLabel位置设定
        startTimeLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -21).isActive = true
        startTimeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 22).isActive = true
        //statusView位置设定
        statusView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -21).isActive = true
        statusView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 71).isActive = true
    }
}
