//
//  MGDGroup.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
///宏定义简化队列的类型
#define serial DISPATCH_QUEUE_SERIAL
#define concurrent DISPATCH_QUEUE_CONCURRENT

NS_ASSUME_NONNULL_BEGIN

@interface MGDGroup : NSObject

@property (nonatomic, readonly) dispatch_group_t dispatchGroup;

#pragma 初始化
- (instancetype)init;

#pragma mark - 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;


@end

NS_ASSUME_NONNULL_END
