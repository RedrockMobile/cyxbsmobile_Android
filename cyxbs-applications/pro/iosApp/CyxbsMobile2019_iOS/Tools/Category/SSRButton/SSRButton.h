//
//  SSRButton.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSRButton : UIButton

/**
 点击区域扩大的 edgeinsets  如 赋值 UIEdgeInsetsMake(10, 20, 30, 40)
 代表向上扩大10，
 向左扩大20， 向下扩大30 ，向右扩大40
 */
@property(nonatomic, assign) UIEdgeInsets expandHitEdgeInsets;

/**
 向上扩展的点击范围
 */
@property(nonatomic, assign) CGFloat expandTopHitEdge;

/**
 向左扩展的点击范围
 */
@property(nonatomic, assign) CGFloat expandLeftHitEdge;
/**
 向下扩展的点击范围
 */
@property(nonatomic, assign) CGFloat expandBottomHitEdge;
/**
 向右扩展的点击范围
 */
@property(nonatomic, assign) CGFloat expandRightHitEdge;
/**
 是否自动扩大点击范围，默认关闭。
 如果开启，并且按钮width 或 height 小于44 ，则将相应的小于44的
 边长的点击范围设置为44
 */
@property(nonatomic, assign) BOOL isAutoHitExpand;

@end

NS_ASSUME_NONNULL_END
