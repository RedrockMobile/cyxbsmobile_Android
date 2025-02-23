//
//  NSDate+Rising.m
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/28.
//

#import "NSDate+Rising.h"

@implementation NSTimeZone (Rising)

+ (NSTimeZone *)CQ {
    return [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
}

@end

@implementation NSLocale (Rising)

+ (NSLocale *)CN {
    return [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
}

@end
