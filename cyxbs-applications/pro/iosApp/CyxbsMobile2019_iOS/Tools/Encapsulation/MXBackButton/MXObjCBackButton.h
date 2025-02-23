//
//  MXObjCBackButton.h
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/3/15.
//  Copyright © 2024 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXObjCBackButton : UIButton

@property (nonatomic, assign) BOOL isAutoHotspotExpand;

/**
 isAutoHotspotExpand为是否自动扩大点击热区，默认关闭。
 如果开启，并且按钮width 或 height 小于44 ，则将相应的小于44的
 边长的点击范围设置为44
 */
- (instancetype)initWithFrame:(CGRect)frame isAutoHotspotExpand:(BOOL)isAutoHotspotExpand;

- (instancetype)initWithIsAutoHotspotExpand:(BOOL)isAutoHotspotExpand;

@end

NS_ASSUME_NONNULL_END
