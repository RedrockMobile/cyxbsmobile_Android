//
//  RisingRouter+Schedule.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/11.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "RisingRouter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ScheduleRouterProtocol;

@interface RisingRouter (Schedule)

- (void)handleScheduleBlock:(void (^)(id <ScheduleRouterProtocol> make))block;

@end

NS_ASSUME_NONNULL_END
