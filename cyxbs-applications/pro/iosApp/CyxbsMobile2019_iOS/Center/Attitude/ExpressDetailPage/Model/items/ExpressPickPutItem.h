//
//  ExpressPickPutItem.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressPickPutItem : NSObject
// statistic
@property (nonatomic, copy) NSDictionary *putStatistic;
// voted
@property (nonatomic, copy) NSString *putVoted;

/// 百分比数组
@property (nonatomic, strong) NSArray<NSString *> *percentStrArray;

/// 小数数组（使用时需要将NSNumber 转换成CGFloat）
@property (nonatomic, strong) NSArray<NSNumber *> *percentNumArray;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

/// 把获取到的static 数据里的投票情况转化为小数占比
- (NSArray *)votedPercentCalculateToString:(NSDictionary *)staticDic;

/// 小数数组（使用时需要将NSNumber 转换成CGFloat）
- (void)votedPercenteCalculateToNSNumber:(NSDictionary *)staticDic;

@end

NS_ASSUME_NONNULL_END
