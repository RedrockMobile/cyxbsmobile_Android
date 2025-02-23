//
//  MXObjCBackButton.m
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/3/15.
//  Copyright © 2024 Redrock. All rights reserved.
//

#import "MXObjCBackButton.h"

@implementation MXObjCBackButton

- (instancetype)initWithFrame:(CGRect)frame isAutoHotspotExpand:(BOOL)isAutoHotspotExpand {
    self = [super initWithFrame:frame];
    if (self) {
        self.isAutoHotspotExpand = isAutoHotspotExpand;
        [self setImage:[UIImage imageNamed:@"activityBack"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return self;
}

- (instancetype)initWithIsAutoHotspotExpand:(BOOL)isAutoHotspotExpand {
    self = [super init];
    if (self) {
        self.isAutoHotspotExpand = isAutoHotspotExpand;
        [self setImage:[UIImage imageNamed:@"activityBack"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [super pointInside:point withEvent:event];
    CGFloat top = 0;
    CGFloat left = 0;
    CGFloat bottom = 0;
    CGFloat right = 0;
    if (self.isAutoHotspotExpand) {
        if (self.frame.size.height < 44) {
            top = (44 - self.frame.size.height)/2.0;
            bottom = (44 - self.frame.size.height)/2.0;
        }
        if (self.frame.size.width < 44) {
            left = (44 - self.frame.size.width)/2.0;
            right = (44 - self.frame.size.width)/2.0;
        }
    }
    //添加负号使相应的内边距变为向外扩展
    UIEdgeInsets hotspotExpandEdge = UIEdgeInsetsMake(- top, - left, - bottom, -right);
    if(UIEdgeInsetsEqualToEdgeInsets(hotspotExpandEdge, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect relativeFrame = self.bounds;
    CGRect hotspot = UIEdgeInsetsInsetRect(relativeFrame, hotspotExpandEdge);
    return CGRectContainsPoint(hotspot, point);
}

@end
