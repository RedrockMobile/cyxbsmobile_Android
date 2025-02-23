//
//  SystemMsgModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SystemMessage.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SystemMsgModel

@interface SystemMsgModel : NSObject

/// 信息集合，因为要做删除操作，用MA
@property (nonatomic, strong, nonnull) NSMutableArray <SystemMessage *> *msgAry;

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

/// 先直接删除，再网络请求删除
/// @param set 哪些需要，也作为删除的set标记
/// @param success 成功删除
/// @param failure 删除失败
- (void)requestRemoveForIndexSet:(NSIndexSet *)set
                         success:(void (^)(void))success
                         failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
