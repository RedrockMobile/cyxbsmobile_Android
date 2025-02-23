//
//  FinderToolsCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/3.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SDWebImage

class FinderToolsCollectionViewCell: UICollectionViewCell {
    
    var imagePostion: BaseButton.ImagePosition = .top
    
    var spaceForMiddle: CGFloat = 7
    
    var imageSize: CGSize? = nil
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        setupFrame()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLab)
        contentView.addSubview(imgView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 11, weight: .medium)
        lab.textColor = .ry(light: "#15315B", dark: "#F0F0F266")
        return lab
    }()
}

extension FinderToolsCollectionViewCell {
    
    func setupData(title: String?, imgName: String) {
        titleLab.text = title
        titleLab.sizeToFit()
        imgView.image = UIImage(named: imgName)
        imgView.contentMode = .scaleAspectFit
        
        setupFrame()
    }
    
    
    func setupFrame() {
        
        let imgSize = imageSize ?? imgView.image?.size ?? imgView.bounds.size
        imgView.frame.size = imgSize
        
        let imgFrame = imgView.frame
        let titleFrame = titleLab.frame
        
        switch imagePostion {
        case .top:
            let spaceForY = (bounds.height - imgFrame.height - titleFrame.height - spaceForMiddle) / 2
            let spaceForImgX = (bounds.width - imgFrame.width) / 2
            let spaceForTilX = (bounds.width - titleFrame.width) / 2
            imgView.frame.origin = CGPoint(x: spaceForImgX, y: spaceForY)
            titleLab.frame.origin = CGPoint(x: spaceForTilX, y: spaceForY + imgFrame.height + spaceForMiddle)
            
        case .left:
            let spaceForX = (bounds.width - imgFrame.width - titleFrame.width - spaceForMiddle) / 2
            let spaceForImgY = (bounds.height - imgFrame.height) / 2
            let spaceForTilY = (bounds.height - titleFrame.height) / 2
            imgView.frame.origin = CGPoint(x: spaceForX, y: spaceForImgY)
            titleLab.frame.origin = CGPoint(x: spaceForX + imgFrame.width + spaceForMiddle, y: spaceForTilY)
            
        case .bottom:
            let spaceForY = (bounds.height - imgFrame.height - titleFrame.height - spaceForMiddle) / 2
            let spaceForTilX = (bounds.width - titleFrame.width) / 2
            let spaceForImgX = (bounds.width - imgFrame.width) / 2
            titleLab.frame.origin = CGPoint(x: spaceForTilX, y: spaceForY)
            imgView.frame.origin = CGPoint(x: spaceForImgX, y: spaceForY + titleFrame.height + spaceForMiddle)
            
        case .right:
            let spaceForX = (bounds.width - imgFrame.width - titleFrame.width - spaceForMiddle) / 2
            let spaceForTilY = (bounds.height - titleFrame.height) / 2
            let spaceForImgY = (bounds.height - imgFrame.height) / 2
            titleLab.frame.origin = CGPoint(x: spaceForX, y: spaceForTilY)
            imgView.frame.origin = CGPoint(x: spaceForX + titleFrame.width + spaceForMiddle, y: spaceForImgY)
        }
    }
}
