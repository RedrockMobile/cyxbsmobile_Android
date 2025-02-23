//
//  LocalNotiManager.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/27.
//  Copyright © 2020 Redrock. All rights reserved.
//用来添加本地通知的一个工具类

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface LocalNotiManager : NSObject

/// 添加本地缓存
/// @param weekNum 第几周提醒，x属于[1, 25]
/// @param weekDay 星期x，x属于[0, 6]
/// @param lesson 第x节大课，x属于[0, 5]
/// @param minute 课前x分钟提醒
/// @param title 提醒标题
/// @param subTitleStr 提醒的子标题
/// @param body 提醒详情
/// @param idStr 本地提醒的ID
+ (void)setLocalNotiWithWeekNum:(int)weekNum weekDay:(int)weekDay lesson:(int)lesson before:(int)minute titleStr:(NSString*)title subTitleStr:(NSString* _Nullable)subTitleStr bodyStr:(NSString*)body ID:(NSString*)idStr;
@end

NS_ASSUME_NONNULL_END
