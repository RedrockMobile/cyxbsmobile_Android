//
//  SportAttendanceItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SportAttendanceItem : NSObject

//日期
@property (nonatomic, strong) NSString *date;
//打卡起始时间
@property (nonatomic, strong) NSString *time;
//地点
@property (nonatomic, strong) NSString *spot;
//打卡类型
@property (nonatomic, strong) NSString *type;
//是否记入奖励
@property (nonatomic, assign) bool is_award;
//是否有效
@property (nonatomic, assign) bool valid;

- (instancetype)init NS_UNAVAILABLE;

/// 根据字典传递初始化
/// @param dic 字典
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
