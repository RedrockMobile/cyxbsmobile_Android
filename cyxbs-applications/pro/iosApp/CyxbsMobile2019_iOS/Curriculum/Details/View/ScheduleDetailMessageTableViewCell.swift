//
//  ScheduleDetailMessageTableViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ScheduleDetailMessageTableViewCell: UITableViewCell {
    
    private let space: CGFloat = 16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        contentView.addSubview(leftLab)
        contentView.addSubview(rightLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var leftLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 15, weight: .regular)
//        lab.textColor = .ry.titleColorForPlace_main
        lab.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return lab
    }()
    
    lazy var rightLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 15, weight: .semibold)
        lab.textAlignment = .right
//        lab.textColor = .ry.titleColorForPlace_main
        lab.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin, .flexibleBottomMargin]
        return lab
    }()
}

extension ScheduleDetailMessageTableViewCell {
    
    func set(leftTitle: String?, rightTitle: String?) {
        leftLab.text = leftTitle
        rightLab.text = rightTitle
        updateFrame()
    }
    
    func updateFrame() {
        leftLab.frame.origin.x = space
        leftLab.sizeToFit()
        leftLab.center.y = contentView.bounds.height / 2
        
        rightLab.sizeToFit()
        rightLab.frame.origin.x = bounds.width - rightLab.bounds.width - space
        rightLab.center.y = contentView.bounds.height / 2
    }
}
