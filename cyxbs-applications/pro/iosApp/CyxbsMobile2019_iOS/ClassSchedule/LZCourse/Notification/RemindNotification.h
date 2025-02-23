//
//  RemindNotification.h
//  Demo
//
//  Created by hzl on 2016/11/30.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindNotification : NSObject
+ (instancetype)shareInstance;

- (void)addNotifictaion;

- (void)deleteNotificationAndIdentifiers;

- (void)updateNotificationWithIdetifiers:(NSString *)newIdentifier;

- (void)deleteAllNotification;

- (void)creatIdentifiers;
@end
