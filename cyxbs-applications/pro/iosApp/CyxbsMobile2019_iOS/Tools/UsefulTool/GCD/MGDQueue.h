//
//  MGDQueue.h
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

@class MGDGroup;

@interface MGDQueue : NSObject

@property (nonatomic,readonly)dispatch_queue_t dispatchQueue;

#pragma mark - 初始化
- (instancetype)init;
- (instancetype)initSerial;
- (instancetype)initSerialWithString:(NSString *)string;
- (instancetype)initConcurrent;
- (instancetype)initConcurrentWithString:(NSString *)string;

#pragma mark - 执行任务
-(void)AsyncTask:(dispatch_block_t)task;
-(void)SyncTask:(dispatch_block_t)task;
-(void)AsyncTask:(dispatch_block_t)task afterDelay:(NSTimeInterval)sec;

#pragma mark - 关于组
-(void)executeTask:(dispatch_block_t)task inGroup:(MGDGroup*)group;
-(void)notifyTask:(dispatch_block_t)task inGroup:(MGDGroup*)group;

/***  暂停函数，暂停对应的调度队列 */
#pragma mark - 暂停函数，暂停对应的系统提供的主队列
- (void)suspend;
- (void)resume;

@end

NS_ASSUME_NONNULL_END
