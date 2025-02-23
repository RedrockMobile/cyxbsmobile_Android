//
//  BaseTabBar.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/3/29.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ClassTabBar.h"
#import "ClassScheduleTabBarView.h"

@implementation ClassTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarHasHidden) name:@"classTabBarHasHidden" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarHasDisplayed) name:@"classTabBarHasDisplayed" object:nil];

    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint hitPoint = [self convertPoint:point fromView:self];
        if (self.classScheduleTabBarView && self.classScheduleTabBarView.userInteractionEnabled && self.alpha!=0 && self.hidden!=YES) {
            if (CGRectContainsPoint(self.classScheduleTabBarView.frame, hitPoint)) {
                view = self.classScheduleTabBarView;
            }
        }
    }
    return view;
}

- (void)tabBarHasHidden {
    self.classScheduleTabBarView.userInteractionEnabled = NO;
}

- (void)tabBarHasDisplayed {
    self.classScheduleTabBarView.userInteractionEnabled = YES;
}

@end
