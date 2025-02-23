//
//  FinderNewsView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/2.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXBanner

class FinderNewsView: UIView {
    
    private(set) var models: [FinderNewsModel] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        addSubview(banner)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var icon: UILabel = {
        let icon = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
        let maskPath = UIBezierPath(roundedRect: icon.bounds, byRoundingCorners: [.bottomLeft, .topRight], cornerRadii: CGSizeMake(10, 10))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        icon.layer.mask = maskLayer
        icon.backgroundColor = .ry(light: "#AFD2FB", dark: "#5A5A5A")
        icon.text = "教务在线"
        icon.font = .systemFont(ofSize: 11, weight: .bold)
        icon.textAlignment = .center
        icon.textColor = .ry(light: "#FFFFFF", dark: "#000000")
        return icon
    }()
    
    lazy var banner: JXBanner = {
        let x = icon.frame.maxX + 14
        let banner = JXBanner(frame: CGRect(x: x, y: 0, width: bounds.width - x, height: bounds.height))
        banner.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        banner.dataSource = self
        banner.delegate = self
        return banner
    }()
}

// MARK: JXBannerDataSource

extension FinderNewsView: JXBannerDataSource {
    
    func jxBanner(numberOfItems banner: JXBannerType) -> Int {
        max(1, models.count)
    }
    
    func jxBanner(_ banner: JXBannerType) -> (JXBannerCellRegister) {
        JXBannerCellRegister(type: FinderNewsCollectionViewCell.self, reuseIdentifier: FinderNewsCollectionViewCell.identifier)
    }
    
    func jxBanner(_ banner: JXBannerType, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        
        guard let cell = cell as? FinderNewsCollectionViewCell else { return cell }
        
        cell.title = "教务新闻功能暂时停止服务..."
        
        return cell
    }
    
    func jxBanner(_ banner: JXBannerType, params: JXBannerParams) -> JXBannerParams {
        params.isAutoPlay = true
        params.timeInterval = 3
        params.cycleWay = .forward
        return params
    }
    
    func jxBanner(_ banner: JXBannerType, layoutParams: JXBannerLayoutParams) -> JXBannerLayoutParams {
        return layoutParams
            .minimumScale(0)
            .maximumAngle(0)
            .itemSpacing(0)
            .scrollDirection(.vertical)
    }
    
    func jxBanner(pageControl banner: JXBannerType, numberOfPages: Int, coverView: UIView, builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        builder
    }
}

// MARK: JXBannerDelegate

extension FinderNewsView: JXBannerDelegate {
    
    func jxBanner(_ banner: JXBannerType, didSelectItemAt index: Int) {
        
    }
}
