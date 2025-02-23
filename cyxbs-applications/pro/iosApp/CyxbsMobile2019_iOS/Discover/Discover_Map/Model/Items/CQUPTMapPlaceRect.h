//
//  CQUPTMapPlaceRect.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/11.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUPTMapPlaceRect : NSObject <NSCoding>

@property (nonatomic, assign) CGFloat totalWidth;
@property (nonatomic, assign) CGFloat totalHeight;

/// 矩形框左边距离最左边的距离占整个宽度的比例
@property (nonatomic, assign) CGFloat percentageLeft;
/// 矩形框右边距离最左边的距离占整个宽度的比例
@property (nonatomic, assign) CGFloat percentageRight;
/// 矩形框上边距离最上边的距离占整个高度的比例
@property (nonatomic, assign) CGFloat percentageTop;
/// 矩形框下边距离最上边的距离占整个高度的比例
@property (nonatomic, assign) CGFloat percentageBottom;

/// 判断某个点是否在该Rect中
/// @param Point 被判断的点
- (BOOL)isIncludePercentagePoint:(CGPoint)Point;

@end

NS_ASSUME_NONNULL_END
