//
//  ScheduleEditSectionCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ScheduleEditSectionCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .ry(light: "#F2F3F7", dark: "#2D2D2D")
        contentView.addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        titleLab.frame.size = layoutAttributes.size
    }
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = .clear
        lab.font = .systemFont(ofSize: 10, weight: .regular)
        lab.textAlignment = .center
        lab.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        return lab
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .ry(light: "#4A44E4", dark: "#465FFF")
                titleLab.textColor = .hex("#FFFFFF")
            } else {
                contentView.backgroundColor = .ry(light: "#F2F3F7", dark: "#2D2D2D")
                titleLab.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
            }
        }
    }
}

extension ScheduleEditSectionCollectionViewCell {
    
    var title: String? {
        set { titleLab.text = newValue }
        get { titleLab.text }
    }
}
