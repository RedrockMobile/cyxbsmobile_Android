//
//  PlaceholderCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/18.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class PlaceholderCollectionViewCell: UICollectionViewCell {
    
    enum ImageName: String {
        
        case boy_404            = "placeholder.empty.boy_404"
        
        case boy_callphone      = "placeholder.empty.boy_callphone"
        
        case boy_check          = "placeholder.empty.boy_check"
        
        case girl_box           = "placeholder.empty.girl_box"
        
        case girl_coffee        = "placeholder.empty.girl_coffee"
        
        case girl_door          = "placeholder.empty.girl_door"
        
        case girl_liedown       = "placeholder.empty.girl_liedown"
        
        case girl_pen           = "placeholder.empty.girl_pen"
        
        case girl_sitting       = "placeholder.empty.girl_sitting"
    }
    
    // MARK: init
    
    override init(frame: CGRect) {
        var frame = frame
        frame.size.width = max(frame.size.width, 130)
        frame.size.height = max(frame.size.height, 104)
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(contentLab)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: property
    
    var imageName: ImageName = .boy_404
    
    var spacing: CGFloat = 16
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: lazy
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 12)
        lab.textColor = .ry(light: "#112C54", dark: "#F0F0F2")
        return lab
    }()
}

// MARK: layout

extension PlaceholderCollectionViewCell {
    
    func placeholder(_ imageName: ImageName, content: String?, spacing: CGFloat = 16) {
        self.spacing = spacing
        let image = UIImage(named: imageName.rawValue)?.scaled(toWidth: 200)?.withRenderingMode(.alwaysOriginal)
        imageView.frame.size = image?.size ?? CGSize(width: 200, height: 130)
        imageView.image = image
        contentLab.text = content
        contentLab.sizeToFit()
        updateFrame()
    }
    
    func updateFrame() {
        let imageSize = imageView.image?.size ?? imageView.bounds.size
        let width = 200.0 / 335.0 * bounds.width
        let height = width / imageSize.width * imageSize.height
        imageView.frame.size = CGSize(width: width, height: height)
        
        let y = (bounds.height - imageView.bounds.height - spacing - contentLab.bounds.height) / 2
        imageView.frame.origin.y = y
        imageView.center.x = bounds.width / 2
        contentLab.frame.origin.y = imageView.frame.maxY + spacing
        contentLab.center.x = bounds.width / 2
    }
}
