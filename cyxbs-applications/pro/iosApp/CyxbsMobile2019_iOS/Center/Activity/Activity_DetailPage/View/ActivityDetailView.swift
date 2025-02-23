//
//  ActivityDetailView.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/24.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityDetailView: UIView {
    
    var informationViews: [UILabel] = []
    var informationLabels: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addSubview(organizerView)
        addSubview(creatorView)
        addSubview(registrationView)
        addSubview(placeView)
        addSubview(informationView)
        addSubview(detailView)
        addSubview(organizerLabel)
        addSubview(creatorLabel)
        addSubview(registrationLabel)
        addSubview(placeLabel)
        addSubview(startTimeView)
        addSubview(endTimeView)
        addSubview(startTimeLabel)
        addSubview(endTimeLabel)
        addSubview(placeImg)
        addSubview(detailLabel)
        addSubview(addTodoButton)
        setPosition()
    }
    
    // MARK: - 设置子视图位置
    func setPosition() {
        organizerLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(22)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(65)
            make.height.equalTo(22)
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(106)
            make.height.equalTo(22)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(147)
            make.height.equalTo(22)
        }
        
        startTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(231)
            make.width.equalTo(162)
            make.height.equalTo(20)
        }
        
        endTimeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(255)
            make.width.equalTo(162)
            make.height.equalTo(20)
        }
        
        placeImg.snp.makeConstraints { make in
            make.right.equalTo(placeLabel.snp.left).offset(-7)
            make.top.equalToSuperview().offset(149)
            make.width.equalTo(16)
            make.height.equalTo(18)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(335)
        }
        
        addTodoButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(0.32 * SCREEN_WIDTH)
            make.height.equalTo(0.044334975369458 * SCREEN_HEIGHT)
            make.top.equalTo(self.snp.top).offset(0.572660098522167 * SCREEN_HEIGHT)
            make.top.greaterThanOrEqualTo(detailLabel.snp.bottom).offset(90)
        }
    }
    
    lazy var organizerView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 24, width: 48, height: 22)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "主办方"
        informationViews.append(label)
        return label
    }()
    
    lazy var creatorView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 65, width: 48, height: 22)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "创建者"
        informationViews.append(label)
        return label
    }()
    
    lazy var registrationView:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 106, width: 64, height: 22)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "报名方式"
        informationViews.append(label)
        return label
    }()
    
    lazy var placeView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 147, width: 64, height: 22)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "活动地点"
        informationViews.append(label)
        return label
    }()
    
    lazy var informationView :UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 199, width: 64, height: 22)
        label.textColor = UIColor(hexString: "#112C54", alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "活动信息"
        return label
    }()
    
    lazy var detailView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 305, width: 64, height: 22)
        label.textColor = UIColor(hexString: "#112C54", alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.text = "活动介绍"
        return label
    }()
    
    lazy var organizerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.8)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.textAlignment = .right
        informationLabels.append(label)
        return label
    }()
    
    lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.8)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.textAlignment = .right
        informationLabels.append(label)
        return label
    }()
    
    lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.8)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.textAlignment = .right
        informationLabels.append(label)
        return label
    }()
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#4A44E4", alpha: 0.7)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.textAlignment = .right
        return label
    }()
    
    lazy var startTimeView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 231, width: 56, height: 20)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.text = "开始时间"
        informationViews.append(label)
        return label
    }()
    
    lazy var endTimeView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 255, width: 56, height: 20)
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.text = "结束时间"
        informationViews.append(label)
        return label
    }()
    
    lazy var startTimeLabel: JustifiedLabel = {
        let label = JustifiedLabel()
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.8)
        label.font = UIFont(name: "PingFangSC-Medium", size: 14)
        informationLabels.append(label)
        return label
    }()
    
    lazy var endTimeLabel: JustifiedLabel = {
        let label = JustifiedLabel()
        label.textColor = UIColor(hexString: "#15315B", alpha: 0.8)
        label.font = UIFont(name: "PingFangSC-Medium", size: 14)
        informationLabels.append(label)
        return label
    }()
    
    lazy var placeImg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "定位")
        return imageView
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#112C54", alpha: 0.4)
        label.font = UIFont(name: "PingFangSC-Medium", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var addTodoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "center_activity_add_todo_enable"), for: .normal)
        button.setImage(UIImage(named: "center_activity_add_todo_disable"), for: .disabled)
        return button
    }()
}

