//
//  FeedBackDetailsRequestDataModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
// model
#import "FeedBackDetailsModel.h"
#import "FeedBackReplyModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
 用来做网络请求
 */
@interface FeedBackDetailsRequestDataModel : NSObject

/// 网络请求
/// @param success 成功之后执行的block
/// @param failure 失败之后,返回字符串
+ (void)getDataAryWithFeedBackID:(long)feedback_id
                         Success:(void (^)(NSArray * array))success
                         failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
