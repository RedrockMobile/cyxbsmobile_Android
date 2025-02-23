//
//  ExpressPickGetItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressPickGetItem.h"
#import "NSDictionaryExtension.h"

@implementation ExpressPickGetItem
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.percentStrArray = [NSArray array];
        self.percentNumArray = [NSArray array];
        self.getId = [dic cm_nsNumberValueForKey:@"id"];
        self.choices = [dic cm_arrayValueForKey:@"choices"];
        self.getVoted = [dic cm_stringValueForKey:@"voted"];
        self.getStatistic = [dic cm_dictionaryValueForKey:@"statistic"]; // 也是字典 { string: number }
        self.title = [dic cm_stringValueForKey:@"title"];
        self.choices = [dic cm_arrayValueForKey:@"choices"];
    }
    return self;
}

/// 把获取到的static 数据里的投票情况转化为小数占比
- (NSArray *)votedPercentCalculateToString:(NSDictionary *)staticDic {
    NSInteger total = 0;
    NSMutableArray *tempMa = [NSMutableArray array];
    for (NSString *key in staticDic) {
        total += [staticDic cm_integerValueForKey:key];
    }
    for (NSString *key in staticDic) {
        CGFloat percent = (CGFloat)[staticDic cm_integerValueForKey:key] / total;
        NSString *formattedString = [NSString stringWithFormat:@"%.0f%%", percent * 100]; // 将浮点数格式化为带两位小数的字符串，并拼接上百分号
        [tempMa addObject:formattedString];
    }
    NSLog(@"static:%@",tempMa);
    return tempMa;
}

/// 小数数组（使用时需要将NSNumber 转换成CGFloat）
- (void)votedPercenteCalculateToNSNumber:(NSDictionary *)staticDic {
    NSInteger total = 0;
    NSMutableArray *tempMa = [NSMutableArray array];
    for (NSString *key in staticDic) {
        total += [staticDic cm_integerValueForKey:key];
    }
    for (NSString *key in staticDic) {
        CGFloat percent = (CGFloat)[staticDic cm_integerValueForKey:key] / total;
        NSNumber *percentNum = [NSNumber numberWithDouble:percent];
        [tempMa addObject:percentNum];
    }
    self.percentNumArray = tempMa;
}

@end
