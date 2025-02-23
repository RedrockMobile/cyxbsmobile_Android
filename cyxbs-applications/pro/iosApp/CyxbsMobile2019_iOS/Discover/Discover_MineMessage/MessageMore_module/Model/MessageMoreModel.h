//
//  MessageMoreModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MessageMoreModel

@interface MessageMoreModel : NSObject

/// 图片
@property (nonatomic, strong) UIImage *msgImg;

/// 文字
@property (nonatomic, strong) NSString *msgStr;

/// 简单初始化
/// @param img 给一个图片
/// @param title 给一个标题
- (instancetype)initWithMsgImg:(UIImage *)img title:(NSString *)title;

/// 初始化system模型
+ (NSArray <MessageMoreModel *> *)systemModels;

/// 初始化active模型
+ (NSArray <MessageMoreModel *> *)activeModels;

@end

NS_ASSUME_NONNULL_END
