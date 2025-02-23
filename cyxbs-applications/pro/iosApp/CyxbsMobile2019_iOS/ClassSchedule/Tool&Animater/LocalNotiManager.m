//
//  LocalNotiManager.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/8/27.
//  Copyright © 2020 Redrock. All rights reserved.
//用来添加本地通知的一个工具类

#import "LocalNotiManager.h"

@implementation LocalNotiManager

+ (void)setLocalNotiWithWeekNum:(int)weekNum weekDay:(int)weekDay lesson:(int)lesson before:(int)minute titleStr:(NSString*)title subTitleStr:(NSString*_Nullable)subTitleStr bodyStr:(NSString*)body ID:(NSString*)idStr{
    if (![self isParamLegalWeekNum:weekNum weekDay:weekDay lesson:lesson]) {
#ifdef DEBUG
        //抛出异常，非DEBUG状态也会崩溃
        @throw [[NSException alloc] initWithName:NSInvalidArgumentException reason:@"参数错误" userInfo:nil];
#endif
        return;
    }
    
    //获取component，component的作用是告诉UNNotificationRequest在什么时候通知
    NSDateComponents *component = [self getComponentWithWeekNum:weekNum weekDay:weekDay lesson:lesson before:minute];
    
    //trigger有好几种，定时、延时、定地点、通知...  这里是定时通知型，不重复
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:NO];
    
    //content的作用是设置通知标题、子标题等
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitleStr;
    content.body = body;
    [content setSound:[UNNotificationSound defaultSound]];
    
    //创建request，还需要一个IDString
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:idStr content:content trigger:trigger];
    
    //[UNUserNotificationCenter currentNotificationCenter]是单例
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

/// 计算提醒时间
/// @param weekNum 第x周，x属于[1, 25]
/// @param weekDay 星期x，x属于[0, 6]
/// @param lesson 第x节大课，x属于[0, 5]
/// @param minute 课前x分钟提醒
+ (NSDateComponents*)getComponentWithWeekNum:(int)weekNum weekDay:(int)weekDay lesson:(int)lesson before:(int)minute{
    
    //intervals里面是上课时间和00:00的秒间隔@"8:00",@"10:15",@"14:00",@"16:15",@"19:00",@"20:50"
    NSTimeInterval intervals[] = {28800,36900,50400,58500,68400,75000};
    
    //和开学日期的天数差
    int dayIntervel = (weekNum-1)*7+weekDay;
    
    NSDate *notiTime = [NSDate dateWithTimeInterval:
                        dayIntervel*86400+  //和开学日期的天数差
                        intervals[lesson]-  //上课的时间
                        minute*60           //课前minute分钟提醒
                                          sinceDate:getDateStart_NSDate];
    
    //获得component
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:notiTime];
    
    return component;
}

+ (BOOL)isParamLegalWeekNum:(int)weekNum weekDay:(int)weekDay lesson:(int)lesson {
    return  0<weekNum&&weekNum<26 && -1<weekDay&&weekDay<7 && -1<lesson&&lesson<6;
}
//Sat Sep 12 20:49:00 2020
@end
//@"y":年,
//@"M":月,
//@"d":日,
//@"k":小时（24小时制）,[1, 24]
//@"m:分"
//@"e":周几，2～周一，1~周日，4～周3
//@"c":周几，2～周一，1~周日，4～周3
