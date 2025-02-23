//
//  RemindNotification.m
//  Demo
//
//  Created by hzl on 2016/11/30.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import "RemindNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface RemindNotification()

@property (nonatomic) NSInteger *arrayCount;

@property (nonatomic) NSInteger newEventCount;
@property (nonatomic, strong) NSMutableDictionary *identifierDic;
@property (nonatomic, strong) NSMutableArray *eventArray;

@end

@implementation RemindNotification
static RemindNotification *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RemindNotification alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (NSMutableArray *)eventArray
{
    if (!_eventArray) {
        _eventArray = [[NSMutableArray alloc] init];
    }
    return _eventArray;
}

- (NSMutableDictionary *)identifierDic
{
    if (!_identifierDic) {
        _identifierDic = [[NSMutableDictionary alloc] init];
    }
    return _identifierDic;
}

- (void)deleteAllNotification
{
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    NSMutableArray *events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    NSDictionary *newDataDic = [[NSDictionary alloc] init];
    
    for (NSInteger i = 0; i < events.count; i++) {
        newDataDic = events[i];
        identifiers = self.identifierDic[newDataDic[@"id"]];
        for (int i = 0; i < identifiers.count; i++) {
            [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifiers[i]]];
        }
        [self.identifierDic removeObjectForKey:newDataDic[@"id"]];
    }
}

- (void)updateNotificationWithIdetifiers:(id)newIdentifier
{
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSDictionary *updateDic = [[NSDictionary alloc] init];
    NSString *lessonDateStr = [[NSString alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSDictionary *dateDic = [[NSDictionary alloc] init];
    NSString *identifier = [[NSString alloc] init];
    NSMutableArray *identifierArray = [[NSMutableArray alloc] init];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:self.identifierDic[newIdentifier]];
    
    for (NSInteger i = 0; i < events.count; i++) {
        if ([[NSString stringWithFormat:@"%@",events[i][@"id"]] isEqualToString:newIdentifier])
        {
            updateDic = events[i];
            break;
        }
    }
    dateArray = updateDic[@"date"];
    for (NSInteger i =  0; i < dateArray.count; i++) {
        dateDic = dateArray[i];
        weekArray = dateDic[@"week"];
        for (NSInteger j = 0; j < weekArray.count; j++) {
            identifier = newIdentifier;
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",weekArray[j]]];
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"day"]]];
            identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"class"]]];
            [identifierArray addObject:identifier];
            
//            if ([[UserDefaultTool valueWithKey:@"nowWeek"] intValue] - [weekArray[j] intValue] <= 0&&updateDic[@"time"]!=nil) {
//                lessonDateStr = [self calculateLessonDateWithWeek:weekArray[j] nowWeek:[NSString stringWithFormat:@"%@",[UserDefaultTool valueWithKey:@"nowWeek"]] day:[NSString stringWithFormat:@"%@",dateDic[@"day"]] class:[NSString  stringWithFormat:@"%@",dateDic[@"class"]]];
//
//                comp = [self calculateNotificationTimeWithIntervalTime:[NSString stringWithFormat:@"%@",updateDic[@"time"]] LessonDate:lessonDateStr];
//
//                [self addNotificationWithTitle:[NSString stringWithFormat:@"%@", updateDic[@"title"]] Content:[NSString stringWithFormat:@"%@", updateDic[@"content"]] Identifier:identifier components:comp];
//            }
            
        }
    }
    [self.identifierDic setObject:identifierArray forKey:newIdentifier];
    self.eventArray = events;
}

- (void)addNotifictaion
{
    NSInteger identifierCount = 0;
    
    NSString *nowWeekStr = [[NSString alloc] init];
    NSString *identifierStr = [[NSString alloc] init];
    NSString *timeStr = [[NSString alloc] init];
    NSString *titleStr = [[NSString alloc] init];
    NSString *contentStr = [[NSString alloc] init];
    NSString *dayStr = [[NSString alloc] init];
    NSString *classStr = [[NSString alloc] init];
    NSString *weekStr = [[NSString alloc] init];
    NSString *lessonDateStr = [[NSString alloc] init];
    
    NSDictionary *newEventDic = [[NSDictionary alloc] init];
    NSDictionary *newEventDateDic = [[NSDictionary alloc] init];
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    
//    nowWeekStr = [NSString stringWithFormat:@"%@",[UserDefaultTool valueWithKey:@"nowWeek"]];
    [self creatIdentifiers];
    
    for (NSInteger i = 0; i < self.newEventCount; i++) {
        
        newEventDic = self.eventArray[self.eventArray.count - 1 - i];
        
        timeStr = [NSString stringWithFormat:@"%@",newEventDic[@"time"]];
        titleStr = [NSString stringWithFormat:@"%@",newEventDic[@"title"]];
        contentStr = [NSString stringWithFormat:@"%@",newEventDic[@"content"]];
        dateArray = newEventDic[@"date"];
        
        for (NSInteger j = 0; j < dateArray.count; j++) {
            newEventDateDic = dateArray[j];
            classStr = [NSString stringWithFormat:@"%@",newEventDateDic[@"class"]];
            dayStr = [NSString stringWithFormat:@"%@",newEventDateDic[@"day"]];
            weekArray = newEventDateDic[@"week"];
            for (NSInteger k = 0; k < weekArray.count; k++) {
                
                weekStr = [NSString stringWithFormat:@"%@",weekArray[k]];
                identifiers = self.identifierDic[newEventDic[@"id"]];
                identifierStr = identifiers[identifierCount];
                identifierCount++;
                
                if ([nowWeekStr intValue] - [weekStr intValue] <= 0&&timeStr!=nil) {
                    lessonDateStr = [self calculateLessonDateWithWeek:weekStr nowWeek:nowWeekStr day:dayStr class:classStr];
                    
                    comp = [self calculateNotificationTimeWithIntervalTime:timeStr LessonDate:lessonDateStr];
                    
                    [self addNotificationWithTitle:titleStr Content:contentStr Identifier:identifierStr components:comp];
                }
                
            }
        }
    }
    
}

- (void)deleteNotificationAndIdentifiers
{
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    NSMutableArray *events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    NSDictionary *newDataDic = [[NSDictionary alloc] init];
    NSDictionary *oldDataDic = [[NSDictionary alloc] init];
    oldDataDic = self.eventArray[0];
    for (NSInteger i = 0; i < events.count; i++) {
        newDataDic = events[i];
        for (NSInteger j = 0 ; j < self.eventArray.count; j++) {
            oldDataDic = self.eventArray[j];
            if (![newDataDic[@"id"] isEqual:oldDataDic[@"id"]])
            {
                goto found;
            }
        }
    }
    found :  identifiers = self.identifierDic[oldDataDic[@"id"]];
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:identifiers];
    [self.identifierDic removeObjectForKey:oldDataDic[@"id"]];
    self.eventArray = events;
}


- (void)creatIdentifiers
{
    self.newEventCount = 0;
    NSString *identifier = [[NSString alloc] init];
    NSMutableArray *events = [[NSMutableArray alloc] init];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"remind.plist"];
    events = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    NSDictionary *dataDic = [[NSDictionary alloc] init];
    NSDictionary *dateDic = [[NSDictionary alloc] init];
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] init];
    NSMutableArray *weekArray = [[NSMutableArray alloc] init];
    NSMutableArray *identifierArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = self.eventArray.count; i < events.count; i++) {
        
        dataDic = events[i];
        dateArray = dataDic[@"date"];
        for (NSInteger j = 0; j < dateArray.count; j++) {
            weekArray = dateArray[j][@"week"];
            dateDic = dateArray[j];
            for (NSInteger k = 0; k < weekArray.count; k++) {
                identifier = [NSString stringWithFormat:@"%@",dataDic[@"id"]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",weekArray[k]]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"day"]]];
                identifier = [identifier stringByAppendingString:[NSString stringWithFormat:@"%@",dateDic[@"class"]]];
                [identifierArray addObject:identifier];
            }
        }
        self.newEventCount++;
        [self.identifierDic setObject:identifierArray forKey:dataDic[@"id"]];
    }
    self.eventArray = events;
}

- (void)addNotificationWithTitle:(NSString *)title Content:(NSString *)text Identifier:(NSString *)identifier components:(NSDateComponents *)comp
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = text;
    
    UNCalendarNotificationTrigger *calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:comp repeats:NO];
    
    //    //测试用trigger
    //        UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30 repeats:NO];
    
    NSString *requestIdentifier = identifier;
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:calendarTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
    }];
}

-(NSDateComponents *)calculateNotificationTimeWithIntervalTime:(NSString *)time
                                                    LessonDate:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    NSTimeInterval timeInterval = [time doubleValue] * 60;
    
    NSDate *intervalTime = [[formatter dateFromString:date]
                            dateByAddingTimeInterval:-timeInterval];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDateComponents *comp = [gregorian components:unitFlags fromDate:intervalTime];
    
    return comp;
}

- (NSString *)calculateLessonDateWithWeek:(NSString *)week nowWeek:(NSString *)nowWeek day:(NSString *)day class:(NSString *)beginClass
{
    NSDictionary *beginTimes = @{@"0":@"8:00",@"1":@"10:15",@"2":@"14:00",@"3":@"16:15",@"4":@"19:00",@"5":@"20:50"};
    
    double oneDay = 24 * 60 * 60;
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    
    double monthDays = ([week doubleValue] - [nowWeek doubleValue]) * 7;
    
    double weekDays =  [day doubleValue] - [[self weekDayStr] doubleValue];
    
    NSDate *intervalDate = [now dateByAddingTimeInterval:monthDays * oneDay];
    
    intervalDate = [intervalDate dateByAddingTimeInterval:weekDays * oneDay];
    
    NSString *dateStr = [formatter stringFromDate:intervalDate];
    
    NSString *timeStr = [NSString stringWithFormat:@" %@",[beginTimes objectForKey:beginClass]];
    
    dateStr = [dateStr stringByAppendingString:timeStr];
    
    return dateStr;
}


- (NSString *)weekDayStr{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [NSDate date];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    if (comps.weekday == 1) {
        comps.weekday = 6;
    }else{
        comps.weekday -= 2;
    }
    NSString *nowWeek = [NSString stringWithFormat:@"%ld",(long)[comps weekday]];
    return nowWeek;
}


@end
