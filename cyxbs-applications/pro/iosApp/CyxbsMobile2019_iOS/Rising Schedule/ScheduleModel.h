//
//  ScheduleModel.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/2.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**课表ScheduleModel模型
 * 通过Array只保存指针的机制，达到数据只有**n类**个
 * 会在不同的下标子array保存相同的数据模型
 * 非常注意这点，在维护的时候尽量使用combine模型
 * combine模型声明了一系列好用的模型数据
 * 我们会根据sno与combineType建立map表
 *
 * 不同的数据都应该为不同的combine模型
 */

#import <Foundation/Foundation.h>

#import "ScheduleCombineModel.h"

#import "ScheduleDiffProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ScheduleModel

@interface ScheduleModel : NSObject

/// 开始的时间
@property (nonatomic, readonly, nonnull) NSDate *startDate;

/// 唯一标识，记录如下
/// 1) 仅用于本地缓存业务，且为DB的路径
/// 2) identifier的算法请自行解决
/// 3) 没课约可用identifier算法进行缓存业务
@property (nonatomic, copy) NSString *identifier;

/// 当周
/// 0代表整周
/// setter里面为once
@property (nonatomic) NSUInteger nowWeek;

/// 课程数组
@property (nonatomic, readonly, nonnull) NSMutableArray <NSMutableArray <ScheduleCourse *> *> *courseAry;

/// 连立一个模型
/// 如果已经根据id连立，则取消该次连立
/// @param model 连立模型
- (void)combineModel:(ScheduleCombineModel *)model;

/// 再次建立联系
/// 如果没有找到，debug会报错
/// 如果模型进行了修改，也使用该方法绑定
/// @param identifier 唯一key值
- (void)recombineWithIdentifier:(NSString *)identifier;

/// 取消连立一个模型
/// 这里不会直接取消内存，你可以根据当时combine的sno再次建立链接
/// @param model 连立模型
- (void)separateModel:(ScheduleCombineModel *)model;

@end

NS_ASSUME_NONNULL_END
