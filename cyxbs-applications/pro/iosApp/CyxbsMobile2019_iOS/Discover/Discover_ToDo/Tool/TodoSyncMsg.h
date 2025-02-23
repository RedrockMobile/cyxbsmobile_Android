//
//  TodoSyncMsg.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/10/18.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, TodoSyncState) {
    TodoSyncStateSuccess,
    TodoSyncStateFailure,
    TodoSyncStateConflict,
    TodoSyncStateUnexpectedError,
};

@interface TodoSyncMsg : NSObject
@property (nonatomic, assign)TodoSyncState syncState;

@property (nonatomic, assign)NSInteger httpCode;

//MARK: - 下面两个时间，在TodoSyncStateConflict的情况下，会用上
/// 服务器的上一次同步时间
@property (nonatomic, assign)NSInteger serverLastSyncTime;
/// 本地的上一次时间
@property (nonatomic, assign)NSInteger clientLastSyncTime;

@end


NS_ASSUME_NONNULL_END
