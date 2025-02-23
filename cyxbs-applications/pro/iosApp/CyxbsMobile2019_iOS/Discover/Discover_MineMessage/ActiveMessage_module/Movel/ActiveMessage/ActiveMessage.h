//
//  ActiveMessage.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ActiveMessage

/// 活动消息
@interface ActiveMessage : UserPublishModel <NSString *>

/// 第二层级跳转URL
@property (nonatomic, copy, nullable) NSString *redirectURL;

/// 在外部的一个图片url
@property (nonatomic, copy) NSString *picURL;

/// 是否已读
@property (nonatomic) BOOL hadRead;

/// 消息唯一 ID
@property (nonatomic) NSInteger msgID;

- (instancetype)init NS_UNAVAILABLE;

/// 根据字典传递初始化
/// @param dic 字典
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
