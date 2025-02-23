//
//  SportAttendanceModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/3.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SportAttendanceItemModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 整体，在这里进行网络请求
@interface SportAttendanceModel : NSObject

@property (nonatomic, assign) NSInteger status;

///data中包含的
//跑步完成
@property (nonatomic, assign) NSInteger run_done;
//跑步总计
@property (nonatomic, assign) NSInteger run_total;
//其他完成
@property (nonatomic, assign) NSInteger other_done;
//其他总计
@property (nonatomic, assign) NSInteger other_total;
//奖励次数
@property (nonatomic, assign) NSInteger award;

/// Item数据传递
@property (nonatomic, strong, nonnull) SportAttendanceItemModel *sAItemModel;

/// 网络请求，isDataCached表示数据是否为从缓存中取出
- (void)requestSuccess:(void (^)(bool isCachedData))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
