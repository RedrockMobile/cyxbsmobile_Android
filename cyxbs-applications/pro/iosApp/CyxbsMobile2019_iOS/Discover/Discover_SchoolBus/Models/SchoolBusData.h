//
//  SchoolBusData.h
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/4/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 校车位置数据
 
 */
@interface SchoolBusData : NSObject

///latitude,纬度 当前车辆的纬度
@property (nonatomic, assign) double latitude;

///longitude,经度 当前车辆的经度
@property (nonatomic, assign) double longitude;

///车辆ID
@property (nonatomic, assign) int busID;

///校车路线
@property (nonatomic, assign) int type;

/**
 字典转模型
 
 @param dict 原始数据字典
 */
+ (instancetype)SchoolBusDataWithDict:(NSDictionary *)dict;

///数据请求
+ (void)SchoolBusDataWithSuccess:(void(^)(NSArray *array))success error:(void(^)(void))error;

@end

NS_ASSUME_NONNULL_END
