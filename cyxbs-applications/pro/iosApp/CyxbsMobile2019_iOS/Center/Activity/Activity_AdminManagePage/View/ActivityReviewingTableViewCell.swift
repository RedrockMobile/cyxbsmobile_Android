//
//  ActivityReviewingTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityReviewingTableViewCell: UITableViewCell {
    
    var activityId: Int = 0
    var agreeButtonTappedHandler: ((Int) -> Void)?
    var rejectButtonTappedHandler: ((Int) -> Void)?
    
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
    
    let typeView: TitleContentView = {
        let view = TitleContentView()
        view.frame = CGRectMake(23, 55, 126, 20)
        view.titleLabel.text = "活动类型:"
        return view
    }()
    
    let creatorView: TitleContentView = {
        let view = TitleContentView()
        view.frame = CGRectMake(23, 77, 120, 20)
        view.titleLabel.text = "创建人:"
        return view
    }()
    
    let phoneView: TitleContentView = {
        let view = TitleContentView()
        view.frame = CGRectMake(23, 99, 126, 20)
        view.titleLabel.text = "联系电话:"
        return view
    }()
    
    let refuseButton : UIButton = {
        let button = UIButton()
        button.size = CGSize(width: 93, height: 34)
        button.setTitle("驳回", for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 14)
        button.setTitleColor(UIColor(red: 0.392, green: 0.388, blue: 0.51, alpha: 1), for: .normal)
        button.backgroundColor = UIColor(red: 0.929, green: 0.929, blue: 0.957, alpha: 1)
        button.layer.cornerRadius = 17
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rejectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let agreeButton : UIButton = {
        let button = UIButton()
        button.size = CGSize(width: 93, height: 34)
        button.setTitle("同意", for: .normal)
        button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCRegular, size: 14)
        button.backgroundColor = UIColor(red: 0.29, green: 0.27, blue: 0.89, alpha: 1)
        button.layer.cornerRadius = 17
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(agreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.973, green: 0.976, blue: 0.988, alpha: 1)
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(startTimeLabel)
        cardView.addSubview(typeView)
        cardView.addSubview(creatorView)
        cardView.addSubview(phoneView)
        cardView.addSubview(agreeButton)
        cardView.addSubview(refuseButton)
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
        titleLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 23).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 22).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //startTimeLabel位置设定
        startTimeLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -21).isActive = true
        startTimeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 22).isActive = true
        //同意按钮位置设定
        agreeButton.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -21).isActive = true
        agreeButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 136).isActive = true
        agreeButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        agreeButton.widthAnchor.constraint(equalToConstant: 93).isActive = true
        //驳回按钮位置设定
        refuseButton.rightAnchor.constraint(equalTo: agreeButton.leftAnchor, constant: -15).isActive = true
        refuseButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 136).isActive = true
        refuseButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        refuseButton.widthAnchor.constraint(equalToConstant: 93).isActive = true
    }
    
    @objc func agreeButtonTapped() {
        agreeButtonTappedHandler?(activityId)
    }
    
    @objc func rejectButtonTapped() {
        rejectButtonTappedHandler?(activityId)
    }
}
