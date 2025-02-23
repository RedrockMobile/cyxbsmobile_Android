//
//  ScheduleRouterProtocol.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/9/4.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**ScheduleRouterProtocol协议
 * 需要到课表业务的请引入这个协议
 * 并且只能使用RisingRouterRequest
 * 请查看“RisingRouterRequest+Schedule.h”扩展提供的API
 */

#import <Foundation/Foundation.h>

#import "RisingRouter+Schedule.h"

#import "ScheduleRequestType.h"

NS_ASSUME_NONNULL_BEGIN

/// 路由名
static NSString *ScheduleRouterName = @"SchedulePresenter";

#pragma mark - ScheduleRouterProtocol

@protocol ScheduleRouterProtocol <NSObject>

- (void)parameterWithRequest:(ScheduleRequestDictionary *)request;

- (UIViewController *)controllerWithStylePush:(BOOL)push
                                   panAllowed:(BOOL)pan;

@end

NS_ASSUME_NONNULL_END
