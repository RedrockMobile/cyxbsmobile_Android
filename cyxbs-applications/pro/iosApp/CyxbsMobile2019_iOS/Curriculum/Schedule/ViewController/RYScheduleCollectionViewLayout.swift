//
//  RYScheduleCollectionViewLayout.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/11.
//  Copyright © 2023 Redrock. All rights reserved.
//

/*
 
 ---------------------------
 wake up    | -1 <  x <   1
 ---------------------------
   1        |  1 <= x <   2
 ---------------------------
 1 - 2      | -2 <  x <= -1
 ---------------------------
   2        |  2 <= x <   3
 ---------------------------
 
 */

import UIKit

// MARK: RYScheduleCollectionViewLayoutDataSource

@objc public
protocol RYScheduleCollectionViewLayoutDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout: RYScheduleCollectionViewLayout, columnOfItemAtIndexPath indexPath: IndexPath) -> Int
    
    func collectionView(_ collectionView: UICollectionView, layout: RYScheduleCollectionViewLayout, lineOfItemAtIndexPath indexPath: IndexPath) -> Int
    
    func collectionView(_ collectionView: UICollectionView, layout: RYScheduleCollectionViewLayout, lenthOfItemAtIndexPath indexPath: IndexPath) -> Int
    
    func collectionView(_ collectionView: UICollectionView, layout: RYScheduleCollectionViewLayout, numberOfSupplementaryOfKind kind: String, inSection section: Int) -> Int
    
    func collectionView(_ collectionView: UICollectionView, layout: RYScheduleCollectionViewLayout, persentOfPointAtIndexPath indexPath: IndexPath) -> CGFloat
}

// MARK: UICollectionView.ElementKindSection

extension UICollectionView {
    
    public enum ElementKindSection: String {
        
        case header = "Redrock.UICollectionView.ElementKindSection.header"
        
        case leading = "Redrock.UICollectionView.ElementKindSection.leading"
        
        case placeHolder = "Redrock.UICollectionView.ElementKindSection.placeHolder"
        
        case pointHolder = "Redrock.UICollectionView.ElementKindSection.pointHolder"
    }
    
    public func register(_ viewClass: AnyClass?, forElementKindSection elementKind: ElementKindSection, withReuseIdentifier identifier: String) {
        register(viewClass, forSupplementaryViewOfKind: elementKind.rawValue, withReuseIdentifier: identifier)
        if let layout = collectionViewLayout as? RYScheduleCollectionViewLayout {
            layout.register(viewClass, forSupplementaryViewOfKind: elementKind.rawValue)
        }
    }
}

extension UICollectionView {
    
    var ry_layout: RYScheduleCollectionViewLayout? {
        collectionViewLayout as? RYScheduleCollectionViewLayout
    }
}

// MARK: RYScheduleCollectionViewLayout

open class RYScheduleCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: Property
    
    open weak var dataSource: RYScheduleCollectionViewLayoutDataSource?
    
    open var lineSpacing: CGFloat = 2
    
    open var columnSpacing: CGFloat = 2
    
    open var widthForLeadingSupplementaryView: CGFloat = 30
    
    private(set) var heightForHeaderSupplementaryView: CGFloat = 0

    open var aspectRatio: CGFloat = 46.0 / 50.0
    
    open var heightForHeader: CGFloat = 50
    
    open var pageCalculation: Int = 0
    
    public var numberOfPages: Int = 0
    
    private(set) open var itemSize: CGSize = .zero
    
    open var pageShows: Int = 1 {
        didSet {
            if pageShows < 1 {
                pageShows = 1
            }
        }
    }
    
    // MARK: Fast Use
    
    open var ry_collectionView: UICollectionView {
        collectionView!
    }
    
    // MARK: Private
    
    private var itemAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    private var supplementaryAttributes: [String: [IndexPath: UICollectionViewLayoutAttributes]] = [:]
    
    // MARK: Method - middle
    
    open func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String) {
        if supplementaryAttributes[elementKind] == nil {
            supplementaryAttributes[elementKind] = [:]
        }
    }
    
    public func indexPath(at point: CGPoint) -> IndexPath {
        let pageWidth = ry_collectionView.bounds.width / CGFloat(pageShows)
        let section = Int( point.x / pageWidth )
        let week = Int (
            (point.x - CGFloat(section) * ry_collectionView.bounds.width - widthForLeadingSupplementaryView) / (itemSize.width + columnSpacing) + 1
        )
        let location = Int(
            (point.y - heightForHeaderSupplementaryView) / (itemSize.height + lineSpacing) + 1
        )
        return IndexPath(arrayLiteral: section, week, location)
    }
    
    // MARK: Method - layoutAttributes
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if numberOfPages <= 0 { return nil }
        
        var result = [UICollectionViewLayoutAttributes]()
        for section in 0 ..< numberOfPages {
            for elementKind in supplementaryAttributes.keys {
                let numberOfSupplementaryOfKind = dataSource?.collectionView(ry_collectionView, layout: self, numberOfSupplementaryOfKind: elementKind, inSection: section) ?? 0
                if numberOfSupplementaryOfKind <= 0 { continue }
                for item in 0..<numberOfSupplementaryOfKind {
                    let indexPath = IndexPath(item: item, section: section)
                    if let attributes = layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) {
                        if rect.intersects(attributes.frame) {
                            result.append(attributes)
                        }
                    }
                }
            }
            let itemCount = collectionView?.dataSource?.collectionView(ry_collectionView, numberOfItemsInSection: section) ?? 0
            if itemCount <= 0 { continue }
            for item in 0 ..< itemCount {
                let indexPath = IndexPath(item: item, section: section)
                if let attributes = layoutAttributesForItem(at: indexPath) {
                    if rect.intersects(attributes.frame) {
                        result.append(attributes)
                    }
                }
            }
        }
        return result
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let dataSource else { return nil }
        let columnOfItem = dataSource.collectionView(ry_collectionView, layout: self, columnOfItemAtIndexPath: indexPath)
        let lineOfItem = dataSource.collectionView(ry_collectionView, layout: self, lineOfItemAtIndexPath: indexPath)
        let lenthOfItem = dataSource.collectionView(ry_collectionView, layout: self, lenthOfItemAtIndexPath: indexPath)
        
        let attribute = itemAttributes[indexPath] ?? UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attribute.zIndex = 4
        attribute.frame = CGRect(
            x: CGFloat(indexPath.section) * ry_collectionView.bounds.width + widthForLeadingSupplementaryView + CGFloat(columnOfItem - 1) * (itemSize.width + columnSpacing),
            y: heightForHeaderSupplementaryView + CGFloat(lineOfItem - 1) * (itemSize.height + lineSpacing) + lineSpacing,
            width: itemSize.width,
            height: CGFloat(lenthOfItem) * itemSize.height + CGFloat(lenthOfItem - 1) * columnSpacing)
        itemAttributes[indexPath] = attribute
        
        return attribute
    }
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let elementKindSection = UICollectionView.ElementKindSection(rawValue: elementKind) else { return nil }
        guard let elementKindAttributes = supplementaryAttributes[elementKind] else { return nil }
        let attributes = elementKindAttributes[indexPath] ?? UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        setupSupplementaryAttributes(attributes, elementKindSection: elementKindSection)
        supplementaryAttributes[elementKind]?[indexPath] = attributes
        return attributes
    }
    
    func setupSupplementaryAttributes(_ attributes :UICollectionViewLayoutAttributes, elementKindSection: UICollectionView.ElementKindSection) {
        
        let indexPath = attributes.indexPath
        let pageWidth = ry_collectionView.bounds.width / CGFloat(pageShows)
        
        switch elementKindSection {
        case .header:
            attributes.zIndex = 10
            
            if indexPath.item == 0 {
                attributes.frame = CGRect(
                    x: CGFloat(indexPath.section) * pageWidth,
                    y: ry_collectionView.contentOffset.y,
                    width: widthForLeadingSupplementaryView,
                    height: heightForHeaderSupplementaryView)
            } else {
                attributes.frame = CGRect(
                    x: CGFloat(indexPath.section) * ry_collectionView.bounds.width + widthForLeadingSupplementaryView + CGFloat(indexPath.item - 1) * (columnSpacing + itemSize.width),
                    y: ry_collectionView.contentOffset.y,
                    width: itemSize.width,
                    height: heightForHeaderSupplementaryView)
            }
            
        case .leading:
            attributes.zIndex = 6
            
            attributes.frame = CGRect(
                x: CGFloat(indexPath.section) * ry_collectionView.bounds.width,
                y: heightForHeaderSupplementaryView + CGFloat(indexPath.item) * (lineSpacing + itemSize.height),
                width: widthForLeadingSupplementaryView,
                height: itemSize.height)
            
        case .placeHolder:
            
            attributes.frame = CGRect(
                x: CGFloat(indexPath.section) * pageWidth + widthForLeadingSupplementaryView,
                y: ry_collectionView.contentOffset.y + heightForHeaderSupplementaryView,
                width: pageWidth - widthForLeadingSupplementaryView,
                height: ry_collectionView.bounds.height - heightForHeaderSupplementaryView)
            
        case .pointHolder:
            attributes.zIndex = 8
            
            let persent = dataSource?.collectionView(ry_collectionView, layout: self, persentOfPointAtIndexPath: indexPath) ?? 0
            print("todo")
        }
    }
    
    // MARK: others
    
    open override func prepare() {
        calculateLayoutIfNeeded()
    }
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    open override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        if context.invalidateDataSourceCounts {
            itemAttributes.removeAll(keepingCapacity: true)
            for key in supplementaryAttributes {
                supplementaryAttributes[key.key]?.removeAll(keepingCapacity: true)
            }
        }
        supplementaryAttributes[UICollectionView.ElementKindSection.header.rawValue]?.forEach { entry in
            self.setupSupplementaryAttributes(entry.value, elementKindSection: .header)
        }
    }
    
    open override var collectionViewContentSize: CGSize {
        let itemCount = 13
        let sections = collectionView?.dataSource?.numberOfSections?(in: ry_collectionView) ?? 0
        return CGSize(
            width: CGFloat(sections) * ry_collectionView.bounds.width,
            height: heightForHeaderSupplementaryView + CGFloat(itemCount) * (itemSize.height + lineSpacing))
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        // 加锁
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        // 定义目标偏移量
        var targetOffset = proposedContentOffset

        // 根据速度计算页面index
        let velocityX = velocity.x
        let pageWidth = ry_collectionView.bounds.width
        var pageIndex = Int(round(proposedContentOffset.x / pageWidth))

        if abs(velocityX) > 20 {
            // 根据速度方向调整pageIndex
            if velocityX > 0 {
                pageIndex += 1
            } else {
                pageIndex -= 1
            }
        }

        // 限制pageIndex范围
        let maxPageIndex = numberOfPages - 1
        pageIndex = min(max(pageIndex, 0), maxPageIndex)

        // 计算targetOffset.x
        targetOffset.x = CGFloat(pageIndex) * pageWidth

        // 返回目标偏移量
        return targetOffset

    }
    
    // MARK: private
    
    private func calculateLayoutIfNeeded() {
        let width = (ry_collectionView.bounds.width - widthForLeadingSupplementaryView) / 7 - columnSpacing
        numberOfPages = collectionView?.dataSource?.numberOfSections?(in: ry_collectionView) ?? 0
        itemSize = CGSize(width: width, height: width / aspectRatio)
        heightForHeaderSupplementaryView = width / aspectRatio
    }
}

/*
 我将代码改为了这个样子
 */
