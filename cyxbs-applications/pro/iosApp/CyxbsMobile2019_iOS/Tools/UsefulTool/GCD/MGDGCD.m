//
//  MGDGCD.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2021/9/9.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MGDGCD.h"

@implementation MGDGCD

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task inQueue:(MGDQueue *)queue{
    NSParameterAssert(task);
    dispatch_sync(queue.dispatchQueue, task);
}

#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task inQueue:(MGDQueue *)queue{
    NSParameterAssert(task);
    dispatch_async(queue.dispatchQueue, task);
}

#pragma mark 和组相关
+ (void)executeTask:(dispatch_block_t)task inQueue:(MGDQueue*)queue
                                           inGroup:(MGDGroup*)group{
    NSParameterAssert(task);
    dispatch_group_async(group.dispatchGroup, queue.dispatchQueue, task);
}

+ (void)notifyTask:(dispatch_block_t)task inQueue:(MGDQueue*)queue
            inGroup:(MGDGroup*)group{
    NSParameterAssert(task);
    dispatch_group_notify(group.dispatchGroup, queue.dispatchQueue, task);
}

/////////////////////类：MainQueue///////////////////////

@end

@implementation MainQueue

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  // 如果当前队列是主队列，要提示奔溃处理
  dispatch_sync(mainQueue, task);
}
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  dispatch_async(mainQueue, task);
}
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec{
  NSParameterAssert(task);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), mainQueue, task);
}
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup *)group{
  NSParameterAssert(task);
    dispatch_group_async(group.dispatchGroup, mainQueue, task);
}
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup *)group{
  NSParameterAssert(task);
    dispatch_group_notify(group.dispatchGroup, mainQueue, task);
}
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend{
  dispatch_suspend(mainQueue);
}
+ (void)resume{
  dispatch_resume(mainQueue);
}

@end

////////////////////类：GlobalQueue////////////////////////

@implementation GlobalQueue

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  // 如果当前队列是主队列，要提示奔溃处理
  dispatch_sync(globalQueue, task);
}
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  dispatch_async(globalQueue, task);
}
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec{
  NSParameterAssert(task);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalQueue, task);
}
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup *)group{
  NSParameterAssert(task);
  dispatch_group_async(group.dispatchGroup, globalQueue, task);
}
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup *)group{
  NSParameterAssert(task);
  dispatch_group_notify(group.dispatchGroup, globalQueue, task);
}
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend{
  dispatch_suspend(globalQueue);
}
+ (void)resume{
  dispatch_resume(globalQueue);
}

@end

////////////////////类：GlobalLowPriorityQueue////////////////////////

@implementation GlobalLowPriorityQueue


#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  // 如果当前队列是主队列，要提示奔溃处理
  dispatch_sync(globalLowPriorityQueue, task);
}
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  dispatch_async(globalLowPriorityQueue, task);
}
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec{
  NSParameterAssert(task);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalLowPriorityQueue, task);
}
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_async(group.dispatchGroup, globalLowPriorityQueue, task);
}
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_notify(group.dispatchGroup, globalLowPriorityQueue, task);
}
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend{
  dispatch_suspend(globalLowPriorityQueue);
}
+ (void)resume{
  dispatch_resume(globalLowPriorityQueue);
}

@end

////////////////////类：GlobalHighPriorityQueue////////////////////////

@implementation GlobalHighPriorityQueue


#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  // 如果当前队列是主队列，要提示奔溃处理
  dispatch_sync(globalHighPriorityQueue, task);
}
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  dispatch_async(globalHighPriorityQueue, task);
}
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelay:(NSTimeInterval)sec{
  NSParameterAssert(task);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalHighPriorityQueue, task);
}
#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_async(group.dispatchGroup, globalHighPriorityQueue, task);
}
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_notify(group.dispatchGroup, globalHighPriorityQueue, task);
}
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend{
  dispatch_suspend(globalHighPriorityQueue);
}
+ (void)resume{
  dispatch_resume(globalHighPriorityQueue);
}

@end

////////////////////类：GlobalBackgroundPriorityQueue////////////////////////

@implementation GlobalBackgroundPriorityQueue

#pragma mark  执行同步任务
+ (void)SyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  // 如果当前队列是主队列，要提示奔溃处理
  dispatch_sync(globalBackgroundPriorityQueue, task);
}
#pragma mark  执行异步任务
+ (void)AsyncTask:(dispatch_block_t)task{
  NSParameterAssert(task);
  dispatch_async(globalBackgroundPriorityQueue, task);
}
#pragma mark  在五个系统提供的队列上，执行延迟任务
+ (void)DelayTask:(dispatch_block_t)task
        afterDelaySecs:(NSTimeInterval)sec{
  NSParameterAssert(task);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * sec), globalBackgroundPriorityQueue, task);
}

#pragma mark  和组相关
/// execute
+ (void)executeTask:(dispatch_block_t)task
          inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_async(group.dispatchGroup, globalBackgroundPriorityQueue, task);
}
///notify
+ (void)notifyTask:(dispatch_block_t)task
         inGroup:(MGDGroup*)group{
  NSParameterAssert(task);
  dispatch_group_notify(group.dispatchGroup, globalBackgroundPriorityQueue, task);
}
#pragma mark  暂停恢复函数，暂停和恢复对应的系统提供的主队列
+ (void)suspend{
  dispatch_suspend(globalBackgroundPriorityQueue);
}
+ (void)resume{
  dispatch_resume(globalBackgroundPriorityQueue);
}

@end

