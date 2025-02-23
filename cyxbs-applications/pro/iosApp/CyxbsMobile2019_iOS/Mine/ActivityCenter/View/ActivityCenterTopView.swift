//
//  UFieldActivityTopView.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/7/24.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit


class ActivityCenterTopView: UIView {
    
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
        setPosition()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    
    //标题
    lazy var titleLab: UILabel = {
        let label = UILabel()
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
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "activityBack"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 23)
        return button
    }()
    
    func setPosition() {
        // 返回按钮
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 13)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        // 标题栏
        self.titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(37)
            make.centerY.equalTo(self.backButton)
            make.width.equalTo(110)
            make.height.equalTo(31)
        }
    }
}
