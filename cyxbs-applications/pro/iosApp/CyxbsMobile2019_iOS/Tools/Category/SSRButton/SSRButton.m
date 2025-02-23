//
//  SSRButton.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SSRButton.h"

@implementation SSRButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    //设置默认的扩展量优先级最低
    if (self.isAutoHitExpand) {
        if (self.frame.size.height < 44) {
            top = (44 - self.frame.size.height)/2.0;
            bottom = (44 - self.frame.size.height)/2.0;
        }
        if (self.frame.size.width < 44) {
            left = (44 - self.frame.size.width)/2.0;
            right = (44 - self.frame.size.width)/2.0;
        }
    }
    //设置四个偏移量次之
    if (!UIEdgeInsetsEqualToEdgeInsets(self.expandHitEdgeInsets, UIEdgeInsetsZero)) {
        top = self.expandHitEdgeInsets.top;
        left = self.expandHitEdgeInsets.left;
        bottom = self.expandHitEdgeInsets.bottom;
        right = self.expandHitEdgeInsets.right;
    }
    //单独设置的偏移量优先级最高
    if (self.expandTopHitEdge) {
        top = self.expandTopHitEdge;
    }
    if (self.expandLeftHitEdge) {
        left = self.expandLeftHitEdge;
    }
    if (self.expandBottomHitEdge) {
        bottom = self.expandBottomHitEdge;
    }
    if (self.expandRightHitEdge) {
        right = self.expandRightHitEdge;
    }
    //添加负号使相应的内边距变为向外扩展
    UIEdgeInsets hitExpandEdge = UIEdgeInsetsMake(- top, - left, - bottom, -right);
    if(UIEdgeInsetsEqualToEdgeInsets(hitExpandEdge, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitExpandEdge);
    return CGRectContainsPoint(hitFrame, point);
}





@end
