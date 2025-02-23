//
//  FeedBackModel.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 每一个 model 对应一个反馈
 */
@interface FeedBackModel : NSObject

/// 反馈的标题
@property (nonatomic, copy) NSString * title;
/// 反馈的ID
@property (nonatomic, assign) long ID;
/// 创建时间
@property (nonatomic, copy) NSString * CreatedAt;
/// 内容
@property (nonatomic, copy) NSString * content;
/// 是否收到回复
@property (nonatomic, assign) BOOL replied;

/// 网络请求
/// @param success 成功之后执行的block
/// @param failure 失败之后,返回字符串
+ (void)getDataArySuccess:(void (^)(NSArray * array))success
                  failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
