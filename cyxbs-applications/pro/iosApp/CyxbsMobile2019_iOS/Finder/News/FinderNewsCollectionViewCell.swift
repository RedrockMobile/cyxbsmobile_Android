//
//  FinderNewsCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/2.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class FinderNewsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLab: UILabel = {
        let lab = UILabel(frame: contentView.bounds)
        lab.textColor = .ry(light: "#15315B", dark: "#F2F4FF")
        lab.font = .systemFont(ofSize: 15, weight: .medium)
        return lab
    }()
}

extension FinderNewsCollectionViewCell {
    
    var title: String? {
        set { titleLab.text = newValue }
        get { titleLab.text }
    }
}
