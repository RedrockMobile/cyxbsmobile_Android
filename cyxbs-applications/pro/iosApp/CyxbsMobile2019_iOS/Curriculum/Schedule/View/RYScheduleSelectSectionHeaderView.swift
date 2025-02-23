//
//  RYScheduleSelectSectionHeaderView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class RYScheduleSelectSectionHeaderView: UIView {
    
    var backTapAction: ((RYScheduleSelectSectionHeaderView) -> ())? = nil
    
    private let space: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backImgView)
        addSubview(segmentView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    lazy var segmentView: JXSegmentedView = {
        let segmentView = JXSegmentedView(frame: bounds)
        segmentView.frame.origin.x = space
        segmentView.frame.size.width = backImgView.frame.minX - 2 * space
        segmentView.dataSource = dataSource
        segmentView.autoresizingMask = [.flexibleWidth]
        return segmentView
    }()

    lazy var dataSource: JXSegmentedTitleDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titles = (0 ... 24).map(ScheduleDataFetch.sectionString(withSection:))
        dataSource.titleSelectedColor = .ry(light: "#15315B", dark: "#F0F0F2")
        dataSource.titleNormalColor = .ry(light: "#15315B", dark: "#F0F0F2")
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 14)
        dataSource.titleSelectedZoomScale = 1.4
        dataSource.isTitleZoomEnabled = true
        dataSource.itemSpacing = 25
        return dataSource
    }()
    
    lazy var backImgView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: bounds.height)))
        imgView.center.y = bounds.height / 2
        imgView.frame.origin.x = bounds.width - imgView.bounds.width - space
        let image = UIImage(named: "direction_left")?
            .tint(.ry(light: "#15315B", dark: "#F0F0F2"), blendMode: .destinationIn)
            .scaled(toHeight: 18)
        imgView.image = image
        imgView.contentMode = .left
        imgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backResponseTap))
        imgView.addGestureRecognizer(tap)
        return imgView
    }()
}

// MARK: response

extension RYScheduleSelectSectionHeaderView {
    
    @objc
    func backResponseTap() {
        backTapAction?(self)
    }
}
