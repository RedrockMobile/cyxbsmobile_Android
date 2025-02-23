//
//  NSDate+Rising.m
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/28.
//

#import "NSDate+Rising.h"

@implementation NSTimeZone (Rising)

+ (NSTimeZone *)CQ {
    static NSTimeZone *CQTimeZone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CQTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Chongqing"];
    });
    return CQTimeZone;
}

@end

@implementation NSLocale (Rising)

+ (NSLocale *)CN {
    static NSLocale *CNLocale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CNLocale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    });
    return CNLocale;
}

@end
