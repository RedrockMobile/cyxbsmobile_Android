//
//  NSDate+Timestamp.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/10/25.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "NSDate+Timestamp.h"

@implementation NSDate (Timestamp)

+ (NSInteger)nowTimestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

@end
