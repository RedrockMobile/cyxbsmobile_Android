//
//  UIScrollView+JHContentExtension.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/29.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (JHContentExtension)

@property (nonatomic, assign) CGFloat jh_contentOffset_y;
@property (nonatomic, assign) CGFloat jh_contentOffset_x;

@property (nonatomic, assign) CGFloat jh_contentInset_top;
@property (nonatomic, assign) CGFloat jh_contentInset_left;
@property (nonatomic, assign) CGFloat jh_contentInset_right;
@property (nonatomic, assign) CGFloat jh_contentInset_bottom;

@end

NS_ASSUME_NONNULL_END
