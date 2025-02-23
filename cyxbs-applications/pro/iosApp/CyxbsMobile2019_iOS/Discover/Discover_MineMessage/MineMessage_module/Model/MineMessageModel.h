//
//  MineMessageModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SystemMsgModel.h"

#import "ActiveMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 整体，在这里进行网络请求
@interface MineMessageModel : NSObject

/// 系统消息传递
@property (nonatomic, strong, nonnull) SystemMsgModel *systemMsgModel;

/// 活动消息传递
@property (nonatomic, strong, nonnull) ActiveMessageModel *activeMsgModel;

/// 网络请求
/// @param success 成功
/// @param failure 失败（乃成功之母）
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
