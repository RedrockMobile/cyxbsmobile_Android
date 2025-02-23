//
//  MGDTimer.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MGDTimer.h"
#import "MGDQueue.h"

@interface MGDTimer ()

// 是否销毁
@property (nonatomic,assign)BOOL isDestroyed;
// 是否恢复
@property (nonatomic,assign)BOOL isAlreadyResume;
// 是否挂起
@property (nonatomic,assign)BOOL isSuspend;

@property (readwrite, nonatomic) dispatch_source_t dispatchSource;

@end

@implementation MGDTimer

- (instancetype)init {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    
    return self;
}

- (instancetype)initInQueue:(MGDQueue *)queue {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.dispatchQueue);
    }
    return self;
}

- (instancetype)initInMainQueue {
    if (self = [super init]) {
        
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    }
    
    return self;
}
- (instancetype)initInGlobalQueue {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    }
    return self;
}
- (instancetype)initInGlobalLowPriorityQueue {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalLowPriorityQueue);
    }
    return self;
}
- (instancetype)initInGlobalHighPriorityQueue {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalHighPriorityQueue);
    }
    return self;
}
- (instancetype)initInGlobalBackgroundPriorityQueue {
    if (self = [super init]) {
        self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalBackgroundPriorityQueue);
    }
    return self;
}

// 初始化状态
- (void)setUp{
    self.isDestroyed = NO;
    self.isAlreadyResume = NO;
    self.isSuspend = NO;
}

- (void)event:(dispatch_block_t)task timeInterval:(uint64_t)interval {
    NSParameterAssert(task);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, task);
    [self setUp];
}

- (void)event:(dispatch_block_t)task timeInterval:(uint64_t)interval delay:(uint64_t)delay {
    NSParameterAssert(task);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delay), interval, 0);
    dispatch_source_set_event_handler(self.dispatchSource, task);
    [self setUp];
}

- (void)event:(dispatch_block_t)task timeIntervalWithSecs:(float)secs {
    NSParameterAssert(task);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, task);
    [self setUp];
}

- (void)event:(dispatch_block_t)task timeIntervalWithSecs:(float)secs delaySecs:(float)delaySecs {
    NSParameterAssert(task);
    dispatch_source_set_timer(self.dispatchSource, dispatch_time(DISPATCH_TIME_NOW, delaySecs * NSEC_PER_SEC), secs * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.dispatchSource, task);
    [self setUp];
}

/**
 *  下面对计时器的启动、挂起和销毁增加了逻辑处理，排除GCD计时器自身的冲突的逻辑
 */

- (void)start {
    if (!self.isDestroyed) {
        if (!self.isAlreadyResume) {
            // 执行/恢复
            dispatch_resume(self.dispatchSource);
            // 标记 表示已经resume
            self.isAlreadyResume = YES;
            // 标记已经恢复了，没有挂起了
            self.isSuspend = NO;
        }
    }
}

- (void)suspend {
    if (!self.isDestroyed) {
        if (!self.isSuspend) {
            if (self.isAlreadyResume) {
                // 挂起
                dispatch_suspend(self.dispatchSource);
                // 记录，已经挂起了
                self.isSuspend = YES;
                // 既然挂起了，所以，就不等于启动
                self.isAlreadyResume = NO;
            }
        }
    }
}

- (void)destroy {
    // 销毁之前，一定要将挂起恢复
    if (self.isSuspend) {
        // 执行/恢复
        dispatch_resume(self.dispatchSource);
        self.isSuspend = NO;
    }
    
    // 如果没销毁，下面进行销毁
    if (!self.isDestroyed) {
        // 不管你是否resume启动了任务，都可以销毁一次
        dispatch_source_cancel(self.dispatchSource);
        // 记录 已经销毁了
        self.isDestroyed = YES;
    }
}

-(void)dealloc{
    self.dispatchSource = nil;
}

@end

