//
//  UIControl+MGD.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/3/14.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "UIControl+MGD.h"
#import <objc/runtime.h>

@implementation UIControl (MGD)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

static const char *UIcontrol_ignoreEvent = "UIcontrol_ignoreEvent";

- (NSTimeInterval)mgd_acceptEventInterval {

    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];

}

- (void)setMgd_acceptEventInterval:(NSTimeInterval)mgd_acceptEventInterval {

    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(mgd_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (BOOL)mgd_ignoreEvent {

    return [objc_getAssociatedObject(self, UIcontrol_ignoreEvent) boolValue];

}

- (void)setMgd_ignoreEvent:(BOOL)mgd_ignoreEvent {

    objc_setAssociatedObject(self, UIcontrol_ignoreEvent, @(mgd_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

+ (void)load {

    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));

    Method b = class_getInstanceMethod(self, @selector(__mgd_sendAction:to:forEvent:));

    method_exchangeImplementations(a, b);

}

- (void)__mgd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {

    if (self.mgd_ignoreEvent) return;

    if (self.mgd_acceptEventInterval > 0) {

        self.mgd_ignoreEvent = YES;

        [self performSelector:@selector(setMgd_ignoreEvent:) withObject:@(NO) afterDelay:self.mgd_acceptEventInterval];

    }

    [self __mgd_sendAction:action to:target forEvent:event];

}

@end
