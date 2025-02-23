//
//  UIScrollView+JHContentExtension.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/29.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "UIScrollView+JHContentExtension.h"

@implementation UIScrollView (JHContentExtension)

#pragma mark - contentOffset

- (void)setJh_contentOffset_x:(CGFloat)jh_contentOffset_x {
    CGPoint offset = self.contentOffset;
    offset.x = jh_contentOffset_x;
    self.contentOffset = offset;
}
- (CGFloat)jh_contentOffset_x {
    return self.contentOffset.x;
}

- (void)setJh_contentOffset_y:(CGFloat)jh_contentOffset_y {
    CGPoint offset = self.contentOffset;
    offset.y = jh_contentOffset_y;
    self.contentOffset = offset;
}
- (CGFloat)jh_contentOffset_y {
    return self.contentOffset.y;
}

#pragma mark - contentInset

- (void)setJh_contentInset_top:(CGFloat)jh_contentInset_top {
    UIEdgeInsets inset = self.contentInset;
    inset.top = jh_contentInset_top;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInset_top {
    return self.contentInset.top;
}

- (void)setJh_contentInset_left:(CGFloat)jh_contentInset_left {
    UIEdgeInsets inset = self.contentInset;
    inset.left = jh_contentInset_left;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInset_left {
    return self.contentInset.left;
}

- (void)setJh_contentInset_right:(CGFloat)jh_contentInset_right {
    UIEdgeInsets inset = self.contentInset;
    inset.right = jh_contentInset_right;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInset_right {
    return self.contentInset.right;
}

- (void)setJh_contentInset_bottom:(CGFloat)jh_contentInset_bottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = jh_contentInset_bottom;
    self.contentInset = inset;
}
- (CGFloat)jh_contentInset_bottom {
    return self.contentInset.bottom;
}

@end
