//
//  ActiveMessageModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ActiveMessage.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ActiveMessageModel

/// 活动消息模型
@interface ActiveMessageModel : NSObject

/// 活动消息
@property (nonatomic, strong, nonnull) NSArray <ActiveMessage *> *activeMsgAry;

/// 根据数组<里面全是字典>
/// @param ary 数组
- (instancetype)initWithArray:(NSArray <NSDictionary *> *)ary;

/// 先自己标为已读，再网络标为已读
/// @param set 哪些需要，可以自动判断原先是否已读
/// @param success 标记成功，基本可以不用管
/// @param failure 标记失败，返回错误信息
- (void)requestReadForIndexSet:(NSIndexSet *)set
                       success:(void (^)(void))success
                       failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
