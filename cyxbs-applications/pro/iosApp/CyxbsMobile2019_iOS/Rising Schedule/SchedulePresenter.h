//
//  SchedulePresenter.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/24.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**SchedulePresenter业务线
 * 充当与路由的搭配业务
 * 路由的类引入@"ScheduleRouterProtocol.h"
 * 路由名：ScheduleRouterName
 * 参数：请使用RisingRouterRequest
 */

#import <Foundation/Foundation.h>

#import "ScheduleController.h"

#import "ScheduleServiceDataSource.h"

#import "ScheduleServiceDelegate.h"

#import "ScheduleRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SchedulePresenter

@interface SchedulePresenter : NSObject <
    RisingRouterHandler,
    ScheduleRouterProtocol
>

/// 控制器
@property (nonatomic, weak) ScheduleController *controller;

/// dataSource业务
@property (nonatomic, strong, nonnull) ScheduleServiceDataSource *dataSourceService;

/// 响应式业务
@property (nonatomic, strong, nonnull) ScheduleServiceDelegate *delegateService;

@end

NS_ASSUME_NONNULL_END
