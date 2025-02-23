//
//  ActivityTopView.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/7/24.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit


class ActivityTopView: UIView {
    
    //标题
    let titleLab: UILabel = {
        let label = UILabel()
        label.text = "活动布告栏"
        label.font = UIFont(name: PingFangSCSemibold, size: 22)
        if #available(iOS 11.0, *) {
            label.textColor = UIColor.dm_color(withLightColor: UIColor(hexString: "#15315B")!, darkColor: UIColor(hexString: "#15315B")!, alpha: 1)
        }
        else {
            label.textColor = UIColor.dm_color(withLightColor: UIColor(hexString: "#15315B")!, darkColor: UIColor(hexString: "#15315B")!, alpha: 1)
        }
        
        return label
    }()
    
    // 返回按钮
    let backButton: UIButton = {
        let button = MXBackButton(frame: .zero, isAutoHotspotExpand: true)
        return button
    }()
    
    //管理员审核按钮
    lazy var adminButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "admin"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    //搜索按钮
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#15315B", alpha: 0.05)
        button.layer.cornerRadius = 19
        button.setTitle("查看更多活动...", for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 16)
        button.setTitleColor(UIColor.dm_color(withLightColor: UIColor(hexString: "#15315B", alpha: 0.2), darkColor: UIColor(hexString: "#15315B", alpha: 0.2)), for: .normal)
        button.setImage(UIImage(named: "放大镜"), for: .normal)
        button.imageView?.size = CGSize(width: 17, height: 18)
        button.titleEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 7, right: 146)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 14, bottom: 11, right: UIScreen.main.bounds.width - 105)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    //添加活动按钮
    let addActivityButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "add"), for: .normal)
        return button
    }()
    
    //排行榜按钮
    let activityHitButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "activityHit"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 11.0, *) {
            self.backgroundColor = UIColor.dm_color(withLightColor: UIColor(hexString: "#FFFFFF")!, darkColor: UIColor(hexString: "#FFFFFF")!, alpha: 1)
        }
        else {
            self.backgroundColor = UIColor(hexString: "#FFFFFF")
        }
        addSubview(titleLab)
        addSubview(backButton)
        addSubview(searchButton)
        addSubview(addActivityButton)
        addSubview(activityHitButton)
        setPosition()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    func setPosition() {
        // 返回按钮
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 13)
            make.width.equalTo(9)
            make.height.equalTo(18)
        }
        // 标题栏
        self.titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37)
            make.centerY.equalTo(self.backButton)
            make.width.equalTo(110)
            make.height.equalTo(31)
        }
        //搜索栏按钮
        self.searchButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.titleLab.snp.bottom).offset(14)
            make.trailing.equalToSuperview().offset(-57)
            make.height.equalTo(38)
        }
        //添加活动按钮
        self.addActivityButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.searchButton)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        //排行榜按钮
        self.activityHitButton.snp.makeConstraints {make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(self.backButton)
            make.width.equalTo(16)
            make.height.equalTo(20.5)
        }
    }
    
    func adAdminButton() {
        addSubview(adminButton)
        self.adminButton.snp.makeConstraints {make in
            make.right.equalToSuperview().offset(-51.98)
            make.centerY.equalTo(self.backButton)
            make.width.equalTo(20.02325)
            make.height.equalTo(21)
        }
    }
    
}
