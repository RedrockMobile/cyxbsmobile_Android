//
//  ScheduleCombineModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**ScheduleCombineModel绑定模型
 * 利用这个模型，在多人查询，可以特别特别快的展示出数据，
 * 实现用户对视觉感知度的提升，性能也能达到不重复请求解决问题
 */

#import <Foundation/Foundation.h>

#import "ScheduleCourse.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * ScheduleCombineType;

#pragma mark - ScheduleCombineModel

@interface ScheduleCombineModel : NSObject

/// 学号，可以确定唯一性
@property (nonatomic, copy, readonly) NSString *sno;

/// 绑定类型，由“系统”/“自定义”决定
@property (nonatomic, copy, readonly) ScheduleCombineType combineType;

/// 唯一标识
/// （计算属性：sno + combineType)
@property (nonatomic, readonly) NSString *identifier;

/// 当周
@property (nonatomic) NSInteger nowWeek;

/// 数据模型
@property (nonatomic, strong, nonnull) NSMutableArray <ScheduleCourse *> *courseAry;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 建立连立模型
/// @param sno 学号
/// @param type 方式
+ (instancetype)combineWithSno:(NSString *)sno type:(ScheduleCombineType)type;

@end

/// 系统
FOUNDATION_EXPORT ScheduleCombineType ScheduleCombineSystem;

/// 自定义
FOUNDATION_EXPORT ScheduleCombineType ScheduleCombineCustom;

NS_ASSUME_NONNULL_END
