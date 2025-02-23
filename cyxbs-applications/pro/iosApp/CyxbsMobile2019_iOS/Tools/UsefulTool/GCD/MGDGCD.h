//
//  MGDGCD.h
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGDQueue.h"
#import "MGDGroup.h"

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


/**
  管理主队列和4个系统的全局并发队列
  可以使用Group，异步和同步和afterDelay
 */

NS_ASSUME_NONNULL_BEGIN

@interface MGDGCD : NSObject

#pragma mark  同步任务
+ (void)SyncTask:(dispatch_block_t)task inQueue:(MGDQueue*)queue;


#pragma mark  异步任务
+ (void)AsyncTask:(dispatch_block_t)task inQueue:(MGDQueue*)queue;

@end

//MainQueue

@interface MainQueue : NSObject

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task;
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task;
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec;
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task inGroup:(MGDGroup *)group;
///notify
+ (void)notifyTask:(dispatch_block_t)task inGroup:(MGDGroup *)group;
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend;
+ (void)resume;

@end


//GlobalQueue


@interface GlobalQueue : NSObject

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task;
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task;
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec;
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup *)group;
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup *)group;
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend;
+ (void)resume;


@end

//GlobalLowPriorityQueue

@interface GlobalLowPriorityQueue : NSObject

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task;
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task;
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec;
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group;
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group;
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend;
+ (void)resume;

@end

//GlobalHighPriorityQueue

@interface GlobalHighPriorityQueue : NSObject

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task;
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task;
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec;
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group;
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group;
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend;
+ (void)resume;

@end

//GlobalBackgroundPriorityQueue

@interface GlobalBackgroundPriorityQueue : NSObject

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task;
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task;
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelaySecs:(NSTimeInterval)sec;
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group;
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group;
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend;
+ (void)resume;

@end


NS_ASSUME_NONNULL_END
