//
//  UserDefaultTool.m
//  MoblieCQUPT_iOS
//
//  Created by 李展 on 2017/8/11.
//  Copyright © 2017年 Orange-W. All rights reserved.
//

#import "UserDefaultTool.h"

@implementation UserDefaultTool
+(void)saveValue:(id) value forKey:(NSString *)key{
    if ([key isEqualToString:@"nowWeek"]) {
        NSInteger nowWeek = [value integerValue];
        NSTimeInterval oneDay = 24*60*60;
        NSDate *nowDate = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
        NSInteger weekDay = (components.weekday+5)%7;
        NSTimeInterval timeInterval = nowDate.timeIntervalSince1970-((nowWeek-1)*7+weekDay)*oneDay;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSString *beginString = [formatter stringFromDate:beginDate];
        beginDate =  [formatter dateFromString:beginString];
        [NSUserDefaults.standardUserDefaults setObject:beginDate forKey:@"beginDate"];
        
    }
    [NSUserDefaults.standardUserDefaults setObject:value forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+(id)valueWithKey:(NSString *)key{
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    if ([key isEqualToString:@"nowWeek"]) {
        NSDate *beginDate = [self valueWithKey:@"beginDate"];
        if (beginDate) {
            NSDate *nowDate = [NSDate date];
            NSTimeInterval oneDay = 24*60*60;
            NSInteger nowWeek = (NSInteger )((nowDate.timeIntervalSince1970-beginDate.timeIntervalSince1970)/oneDay/7+1);
//            NSNumber *nowWeek = @((int)(nowDate.timeIntervalSince1970-beginDate.timeIntervalSince1970)/oneDay/7+1);
            [userDefaults setObject:@(nowWeek) forKey:@"nowWeek"];
        }
    }
    return [userDefaults objectForKey:key];
}

+(BOOL)boolValueWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    return [userDefaults boolForKey:key];
}

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key
{
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

+ (void)saveParameter:(NSDictionary *)paramterDic{
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    [paramterDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([key isEqualToString:@"id"]){
            key = @"user_id";
        }
        if ([key isEqualToString:@"nowWeek"]) {
            NSInteger nowWeek = [obj integerValue];
            NSTimeInterval oneDay = 24*60*60;
            NSDate *nowDate = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:nowDate];
            NSInteger weekDay = (components.weekday+5)%7;
            NSTimeInterval timeInterval = nowDate.timeIntervalSince1970-((nowWeek-1)*7+weekDay)*oneDay;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSDate *beginDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            NSString *beginString = [formatter stringFromDate:beginDate];
            beginDate = [formatter dateFromString:beginString];
            [userDefaults setObject:beginDate forKey:@"beginDate"];
        }
        [userDefaults setObject:obj forKey:key];
    }];
    [lock unlock];
}

+(void)print{
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    NSLog(@"%@",dic);
}

+(NSString *)getStuNum{
    NSString* stuNum = [self valueWithKey:@"stuNum"];
    if (stuNum==nil) {
        stuNum = @"";
    }
    return stuNum;
}

+(void)saveStuNum:(NSString *)stuNum{
    [self saveValue:stuNum forKey:@"stuNum"];
}

+(NSString *)getIdNum{
    return [self valueWithKey:@"idNum"];
}

+(void)saveIdNum:(NSString *)idNum {
    [self saveValue:idNum forKey:@"idNum"];
}

+ (void)saveRefreshToken:(NSString *)refresh {
    [self saveValue:refresh forKey:@"refreshToken"];
}

+ (NSString *)getRefreshToken {
    return [self valueWithKey:@"refreshToken"];
}

+ (void)saveToken:(NSString *)token {
    [self saveValue:token forKey:@"token"];
}

+ (NSString *)getToken {
    return [self valueWithKey:@"token"];
}

+(void)removeALLData{
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (id key in dic) {
        [defaults removeObjectForKey:key];
    }
}

@end
