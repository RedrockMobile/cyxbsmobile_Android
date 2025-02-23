//
//  FinderBannerCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/30.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SDWebImage

class FinderBannerCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(imgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView(frame: contentView.bounds)
        imgView.contentMode = .scaleToFill
        return imgView
    }()
}

extension FinderBannerCollectionViewCell {
    
    func setImage(with urlStr: String, placeholder img: UIImage?) {
        let url = URL(string: urlStr)
        imgView.sd_setImage(with: url, placeholderImage: img)
        imgView.contentMode = .scaleToFill
    }
}
