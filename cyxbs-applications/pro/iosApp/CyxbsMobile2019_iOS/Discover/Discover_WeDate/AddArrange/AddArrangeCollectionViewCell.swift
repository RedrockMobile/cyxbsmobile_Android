//
//  AddArrangeCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/9/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

/// 复用标志
let AddArrangeCollectionViewCellReuseIdentifier = "AddArrangeCollectionViewCell"

class AddArrangeCollectionViewCell: UICollectionViewCell {
    
    var isSelectedCell: Bool = false
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                label.textColor = UIColor(hexString: "#4A44E4", alpha: 1)
                contentView.backgroundColor = UIColor(hexString: "#E8E8FE", alpha: 1)
            } else {
                label.textColor = UIColor(hexString: "#2D4D80", alpha: 0.6)
                contentView.backgroundColor = UIColor(hexString: "#F2F5FF", alpha: 1)
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        clipsToBounds = true
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor(hexString: "#F2F5FF", alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lazy
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(hexString: "#2D4D80", alpha: 0.6)
        return label
    }()
}
