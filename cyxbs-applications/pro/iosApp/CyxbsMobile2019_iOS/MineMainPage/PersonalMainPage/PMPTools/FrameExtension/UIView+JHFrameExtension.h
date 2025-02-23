//
//  UIView+JHFrame.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHFrameExtension)

@property (nonatomic, assign) CGPoint jh_origin;
@property (nonatomic, assign) CGFloat jh_x;
@property (nonatomic, assign) CGFloat jh_y;

@property (nonatomic, assign) CGSize jh_size;
@property (nonatomic, assign) CGFloat jh_width;
@property (nonatomic, assign) CGFloat jh_height;

/// 最大X
- (CGFloat)jh_maxX;
/// 最大Y
- (CGFloat)jh_maxY;

@end

NS_ASSUME_NONNULL_END
