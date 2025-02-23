//
//  SystemMessage.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MineMessage

/// 一条我的消息类型
@interface SystemMessage : UserPublishModel<NSString *>

/// 是否已读
@property (nonatomic) BOOL hadRead;

- (instancetype)init NS_UNAVAILABLE;

/// 根据字典创建次类型
/// @param dic 字典
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

#pragma mark - UserPublishModel (SystemMessage)

@interface UserPublishModel (SystemMessage)

- (instancetype) initWithSysDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
