//
//  PodEX.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/15.
//  Copyright © 2023 Redrock. All rights reserved.
//

import MJRefresh

// MARK: MJRefreshGifHeader

/*
 
 let header = MJRefreshGifHeader {
     <#self.cleanAndReload()#>
 }
 .autoChangeTransparency(true)
 .set_refresh_sports()
 .link(to: <#collectionView#>)
 
 */

extension MJRefreshHeader {
    
    @discardableResult
    func ignoredScrollView(contentInsetTop: CGFloat) -> Self {
        ignoredScrollViewContentInsetTop = contentInsetTop
        return self
    }
    
    @discardableResult
    func isCollectionViewAnimationBug(open: Bool) -> Self {
        isCollectionViewAnimationBug = open
        return self
    }
}

extension MJRefreshGifHeader {
    
    @discardableResult
    func set_refresh_sports() -> Self {
        let iamgeCount = 12
        var images = [UIImage]()
        let image_0 = UIImage(named: "refresh_sport_0")!
        for i in 0 ..< iamgeCount {
            if let image = UIImage(named: String(format: "refresh_sport_%d", i)) {
                images.append(image)
            }
        }
        let idleImages = [image_0, image_0] + images + [image_0, image_0]
        setImages(idleImages, for: .idle)
        setImages(images, for: .refreshing)
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
        return self
    }
}
