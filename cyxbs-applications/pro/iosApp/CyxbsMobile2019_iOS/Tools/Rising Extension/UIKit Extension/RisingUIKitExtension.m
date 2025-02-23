//
//  RisingUIKitExtension.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const UICollectionElementKindSectionLeading = @"UICollectionElementKindSectionLeading";

NSString *const UICollectionElementKindSectionTrailing = @"UICollectionElementKindSectionTrailing";

NSString *const UICollectionElementKindSectionPlaceholder = @"UICollectionElementKindSectionPlaceholder";

CGFloat StatusBarHeight(void) {
    static CGFloat statusBarHeight = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 13.0, *)) {
            statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
            
        } else {
            statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    });
    return statusBarHeight;
}
