//
//  StationData.h
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2022/5/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 站点位置数据
@interface StationData : NSObject

/// 线路id
@property (nonatomic, assign) int line_id;
/// 线路名称
@property (nonatomic, copy) NSString *line_name;
/// 运行时间
@property (nonatomic, copy) NSString *run_time;
/// 发车类型（单向发车 or 双向发车
@property (nonatomic, copy) NSString *send_type;
/// 运行类型（往返 or 环线)
@property (nonatomic, copy) NSString *run_type;
/// 站点
@property (nonatomic, copy) NSArray *stations;



+ (instancetype)StationDataWithDict:(NSDictionary *)dict;

+ (void)StationWithSuccess:(void (^)(NSArray * _Nonnull array))success
                   Failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
