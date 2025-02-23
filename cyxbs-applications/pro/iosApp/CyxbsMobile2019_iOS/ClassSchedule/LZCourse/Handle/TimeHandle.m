//
//  TimeHandle.m
//  Demo
//
//  Created by 李展 on 2016/12/7.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "TimeHandle.h"
@implementation TimeHandle
+ (NSString *)handleTimes:(NSArray *)times{
    NSArray *dayArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSArray *lessonArray = @[@"12节",@"34节",@"56节",@"78节",@"910节",@"1112节"];
    NSMutableString *content = [NSMutableString string];
    for (int i = 0; i<times.count; i++) {
        int tag = [times[i] intValue];
        if (i == 0) {
            content = [[dayArray[tag/(LONGLESSON)] stringByAppendingString:lessonArray[tag%(LONGLESSON)]] mutableCopy];
        }
        else{
            NSLog(@"%d",tag%(LONGLESSON));
            [content appendFormat:@"、%@",[[dayArray[tag/(LONGLESSON)]stringByAppendingString:lessonArray[tag%(LONGLESSON)]] mutableCopy]];
        }
    }
    return content;
}
+ (NSString *)handleWeeks:(NSArray *)weeks{
    NSMutableString *content = [NSMutableString string];
    for (int i = 0; i<weeks.count; i++) {
        if (i==0) {
            content = [[weeks[0] stringValue] mutableCopy];
        }
        else{
            [content appendFormat:@"、%@",weeks[i]];
        }
    }
    if (![content isEqualToString:@""]) {
        [content appendString:@"周"];
    }
    return content.copy;
}
@end
