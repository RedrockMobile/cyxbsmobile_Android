//
//  MGDTimer.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#define mainQueue dispatch_get_main_queue()
// 四个不同优先级的全局并发队列
#define globalQueue \
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define globalHighPriorityQueue \
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)

#define globalLowPriorityQueue \
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)

#define globalBackgroundPriorityQueue \
dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

NS_ASSUME_NONNULL_BEGIN

@class MGDQueue;

@interface MGDTimer : NSObject
@property (readonly, nonatomic) dispatch_source_t dispatchSource;

#pragma 初始化
- (instancetype)init;
- (instancetype)initInQueue:(MGDQueue *)queue;
- (instancetype)initInMainQueue;
- (instancetype)initInGlobalQueue;
- (instancetype)initInGlobalLowPriorityQueue;
- (instancetype)initInGlobalHighPriorityQueue;
- (instancetype)initInGlobalBackgroundPriorityQueue;

#pragma mark - 用法
- (void)event:(dispatch_block_t)task timeInterval:(uint64_t)interval;
- (void)event:(dispatch_block_t)task timeInterval:(uint64_t)interval delay:(uint64_t)delay;
- (void)event:(dispatch_block_t)task timeIntervalWithSecs:(float)secs;
- (void)event:(dispatch_block_t)task timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs;

#pragma mark - 计时器的开始、暂停和销毁操作
- (void)start;
- (void)suspend;
- (void)destroy;

@end


NS_ASSUME_NONNULL_END
