//
//  RisingRouter+Schedule.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/11.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "RisingRouter+Schedule.h"

#import "SchedulePresenter.h"

@implementation RisingRouter (Schedule)

- (void)handleScheduleBlock:(void (^)(id<ScheduleRouterProtocol> _Nonnull))block {
    SchedulePresenter *presenter = [[SchedulePresenter alloc] init];
    if (block) {
        block(presenter);
    }
}

@end
