//
//  ExpressPickPutItem.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressPickPutItem.h"
#import "NSDictionaryExtension.h"

@implementation ExpressPickPutItem
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.percentStrArray = [NSArray array];
        self.percentNumArray = [NSArray array];
        self.putStatistic = [dic cm_dictionaryValueForKey:@"statistic"]; // 字典 { string: number }
        self.putVoted = [dic cm_stringValueForKey:@"voted"];
    }
    return self;
}

/// 把获取到的static 数据里的投票情况转化为小数占比
- (NSArray *)votedPercentCalculateToString:(NSDictionary *)staticDic {
    NSInteger total = 0;
    NSArray *valueArray = [staticDic allValues];
    for (int i = 0; i < valueArray.count; ++i) {
        total += [(NSNumber *)valueArray[i] longLongValue];
    }
    NSMutableArray *tempMa = [NSMutableArray array];
    for (int j = 0; j < valueArray.count; ++j) {
        double percentInteger = (double) [(NSNumber *)valueArray[j] longLongValue] / total;
        CGFloat percentFloat = percentInteger; // 将 NSInteger 转换为浮点数类型
        NSString *formattedString = [NSString stringWithFormat:@"%.0f%%", percentFloat * 100]; // 将浮点数格式化为带两位小数的字符串，并拼接上百分号
        [tempMa addObject:formattedString];
    }
    NSLog(@"static:%@",tempMa);
    valueArray = tempMa;
    return valueArray;
}

/// 小数数组（使用时需要将NSNumber 转换成CGFloat）
- (void)votedPercenteCalculateToNSNumber:(NSDictionary *)staticDic {
    NSInteger total = 0;
    NSArray *valueArray = [staticDic allValues];
    for (int i = 0; i < valueArray.count; ++i) {
        total += [(NSNumber *)valueArray[i] longLongValue];
    }
    NSMutableArray *tempMa = [NSMutableArray array];
    for (int j = 0; j < valueArray.count; ++j) {
        double percentInteger = (double)[(NSNumber *)valueArray[j] longLongValue] / total;
        NSNumber *percentNum = [NSNumber numberWithDouble:percentInteger];
        [tempMa addObject:percentNum];
    }
//    NSLog(@"percentNum-tempMa-put:%@",tempMa);
    self.percentNumArray = tempMa;
}
@end
