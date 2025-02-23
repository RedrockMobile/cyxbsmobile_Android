//
//  TodoDateTool.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/8/25.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "TodoDateTool.h"
#import <UserNotifications/UserNotifications.h>

@implementation TodoDateTool
+ (void)removeAllNotiInModel:(TodoDataModel*)model {
    if ([model.timeStr isEqualToString:@""]) {
        return;
    }
    NSMutableArray<NSString*>* notiIDArr = [NSMutableArray arrayWithCapacity:5];
    [notiIDArr addObject:[NSString stringWithFormat:@"%@ + ONCE",model.todoIDStr]];
    
    switch (model.repeatMode) {
        case TodoDataModelRepeatModeNO:
            break;
        case TodoDataModelRepeatModeDay:
            [notiIDArr addObject:[NSString stringWithFormat:@"%@ + DAY", model.todoIDStr]];
            break;
        case TodoDataModelRepeatModeWeek:
            for (NSString* weekStr in model.weekArr) {
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + WEEK + %ld", model.todoIDStr, weekStr.integerValue]];
            }
            break;
        case TodoDataModelRepeatModeMonth:
            for (NSString* dayStr in model.dayArr) {
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + MONTH + %ld", model.todoIDStr, dayStr.integerValue]];
            }
            break;
        case TodoDataModelRepeatModeYear:
            for (NSDictionary<TodoDataModelKey, NSString*>* dict in model.dateArr) {
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + YEAR + %ld", model.todoIDStr, dict[TodoDataModelKeyMonth].integerValue*31 + dict[TodoDataModelKeyDay].integerValue]];
            }
            break;
    }
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeDeliveredNotificationsWithIdentifiers:notiIDArr];
    [center removePendingNotificationRequestsWithIdentifiers:notiIDArr];
}
+ (void)addNotiWithModel:(TodoDataModel*)model {
    if ([model.timeStr isEqualToString:@""]) {
        return;
    }
    
    NSCalendarUnit unit = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday);
    NSDateComponents* components = [[NSCalendar currentCalendar] components:unit fromDate:[model getTimeStrDate]];
    UNNotificationContent* content = [self getContentWithModel:model];
    
    if (model.repeatMode!=TodoDataModelRepeatModeNO) {
        [self addNotiForRepaetTypeModel:model content:content hour:components.hour minute:components.minute];
    }
    
    //添加设置提醒时间界面的那一次提醒
    [self addNotiForOnceModel:model content:content onceComponents:components];
    
}
+ (void)addNotiForOnceModel:(TodoDataModel*)model content:(UNNotificationContent*)content onceComponents:(NSDateComponents*)components {
    switch (model.repeatMode) {
        case TodoDataModelRepeatModeNO:
            break;
        case TodoDataModelRepeatModeDay:
            return;
            break;
        case TodoDataModelRepeatModeWeek:
            for (NSString* weekStr in model.weekArr) {
                if (weekStr.integerValue==components.weekday) {
                    return;
                }
            }
            break;
        case TodoDataModelRepeatModeMonth:
            for (NSString* dayStr in model.dayArr) {
                if (dayStr.integerValue==components.day) {
                    return;
                }
            }
            break;
        case TodoDataModelRepeatModeYear:
            for (NSDictionary<TodoDataModelKey, NSString*>* dict in model.dateArr) {
                if (components.month==dict[TodoDataModelKeyMonth].integerValue&&components.day==dict[TodoDataModelKeyDay].integerValue) {
                    return;
                }
            }
            break;
    }
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"%@ + ONCE",model.todoIDStr] content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

+ (void)addNotiForRepaetTypeModel:(TodoDataModel*)model content:(UNNotificationContent*)content hour:(NSInteger)hour minute:(NSInteger)minute {
    //设置重复的：
    NSMutableArray<UNCalendarNotificationTrigger*>* triggerArr = [NSMutableArray arrayWithCapacity:4];
    NSMutableArray<NSString*>* notiIDArr = [NSMutableArray arrayWithCapacity:4];
    switch (model.repeatMode) {
        case TodoDataModelRepeatModeNO:
            break;
        case TodoDataModelRepeatModeDay: {
            NSDateComponents* components = [[NSDateComponents alloc] init];
            components.hour = hour;
            components.minute = minute;
            UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
            [triggerArr addObject:trigger];
            [notiIDArr addObject:[NSString stringWithFormat:@"%@ + DAY", model.todoIDStr]];
        }
            break;
        case TodoDataModelRepeatModeWeek:{
            for (NSString* weekStr in model.weekArr) {
                NSDateComponents* components = [[NSDateComponents alloc] init];
                components.weekday = weekStr.integerValue;
                components.hour = hour;
                components.minute = minute;
                UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
                [triggerArr addObject:trigger];
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + WEEK + %ld", model.todoIDStr, weekStr.integerValue]];
            }
        }
            break;
        case TodoDataModelRepeatModeMonth:{
            for (NSString* dayStr in model.dayArr) {
                NSDateComponents* components = [[NSDateComponents alloc] init];
                components.day = dayStr.integerValue;
                components.hour = hour;
                components.minute = minute;
                UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
                [triggerArr addObject:trigger];
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + MONTH + %ld", model.todoIDStr, dayStr.integerValue]];
            }
        }
            break;
        case TodoDataModelRepeatModeYear: {
            for (NSDictionary<TodoDataModelKey, NSString*>* dict in model.dateArr) {
                NSDateComponents* components = [[NSDateComponents alloc] init];
                components.month = dict[TodoDataModelKeyMonth].integerValue;
                components.day = dict[TodoDataModelKeyDay].integerValue;
                components.hour = hour;
                components.minute = minute;
                UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
                [triggerArr addObject:trigger];
                //可以推导出month*31 + day可以唯一标识一年中的某一天
                [notiIDArr addObject:[NSString stringWithFormat:@"%@ + YEAR + %ld", model.todoIDStr, components.month*31 + components.day]];
            }
        }
            break;
    }
    NSInteger i = 0;
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    for (UNCalendarNotificationTrigger* trigger in triggerArr) {
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:notiIDArr[i++] content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

+ (UNNotificationContent*)getContentWithModel:(TodoDataModel*)model {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"你今天有一个事项待完成～";
    content.body = model.detailStr;
    content.subtitle = model.titleStr;
    content.sound = [UNNotificationSound defaultSound];
    return content;
}

//MARK: +++++++++++++++++++++计算下一次提醒日期的方法++++++++++++++++++++++++++++
+ (long)getOverdueTimeStampFrom:(long)timeStamp inModel:(TodoDataModel*)model {
    if (timeStamp < 0) {
        //避免timeStampOfOnceDate指向过去，且是不重复的情况下，日期反复横跳。
        return timeStamp;
    }
    //不提醒的情况下，过期时间为那一天的24:00:00
    if ([model.timeStr isEqualToString:@""]) {
        return [self getOverdueTimeStampFrom:timeStamp remindHour:24 remindMinute:00 remindSecond:00 inModel:model];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年M月d日HH:mm"];
    NSDate* onceDate = [formatter dateFromString:model.timeStr];
    NSDateComponents* onceDateComponents = [[NSCalendar currentCalendar] components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:onceDate];
    
    long timeStampOfNextRepeatRemind = [self getOverdueTimeStampFrom:timeStamp remindHour:onceDateComponents.hour remindMinute:onceDateComponents.minute remindSecond:0 inModel:model];
    
    long timeStampOfOnceDate = onceDate.timeIntervalSince1970;
    
    if (timeStampOfOnceDate>timeStamp && (timeStampOfNextRepeatRemind==-1||timeStampOfNextRepeatRemind>timeStampOfOnceDate)) {
        return timeStampOfOnceDate;
    }else {
        return timeStampOfNextRepeatRemind;
    }
}


/// 从timeStamp指向时间点起，根据model的重复提醒相关的数据，
/// 往未来寻找下一次提醒的时间，不考虑设置提醒界面的那一次提醒。
/// 当且仅当模式为不重复模式时返回-1
/// @param timeStamp 指向某一个时间点的时间戳
/// @param hour 提醒的时
/// @param minute 提醒的分
/// @param second 提醒的秒
+ (long)getOverdueTimeStampFrom:(long)timeStamp remindHour:(NSInteger)hour remindMinute:(NSInteger)minute remindSecond:(NSInteger)second inModel:(TodoDataModel*)model{
    //经过实测，在timeStamp指向某一次提醒时，返回值可能仍为timeStamp的情况没有发生，为了更保险再加个10秒
    timeStamp += 10;
    NSDate* begainDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    //周秒分时日月年
    NSCalendarUnit unit = (NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth);
    
    NSDateComponents* begainComponents = [[NSCalendar currentCalendar] components:unit fromDate:begainDate];
    NSTimeInterval notiSecond = (hour*60 + minute)*60 + second;
    NSTimeInterval begainSecond = (begainComponents.hour*60 + begainComponents.minute)*60 + begainComponents.second;
    
    NSDate* notiDate = nil;
    switch (model.repeatMode) {
        case TodoDataModelRepeatModeNO:
            break;
        case TodoDataModelRepeatModeDay: {
            NSTimeInterval interval = notiSecond - begainSecond;
            if (interval <= 0) {
                //明天
                interval += 86400;
            }
            notiDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:begainDate];
            break;
        }
        case TodoDataModelRepeatModeWeek: {
            NSTimeInterval interval = notiSecond - begainSecond - ForeignWeekToChinaWeek((int)begainComponents.weekday)*86400;
            NSInteger intWeekArr[model.weekArr.count];
            getSortedChainaIntWeekArr(model.weekArr, intWeekArr);
            NSInteger cnt = model.weekArr.count;
            for (int i=0; i<cnt; i++) {
                if (intWeekArr[i]*86400 + interval > 0) {
                    notiDate = [[NSDate alloc] initWithTimeInterval:intWeekArr[i]*86400 + interval sinceDate:begainDate];
                    break;
                }
            }
            
            //下一周
            if (notiDate==nil) {
                notiDate = [[NSDate alloc] initWithTimeInterval:(intWeekArr[0]+7)*86400 + interval sinceDate:begainDate];
            }
            break;
        }
        case TodoDataModelRepeatModeMonth: {
            NSTimeInterval interval = notiSecond - begainSecond - begainComponents.day*86400;
            NSInteger cnt;
            NSInteger numberOfDayInMonth = [self getNumberOfDaysInMonth:begainDate];
            NSInteger intDayArr[model.dayArr.count];
            getSortedIntDayArr(model.dayArr, intDayArr, &cnt, numberOfDayInMonth);
            
            //在本月范围寻找
            for (int i=0; i<cnt; i++) {
                if (intDayArr[i]*86400 + interval > 0) {
                    notiDate = [NSDate dateWithTimeInterval:intDayArr[i]*86400 + interval sinceDate:begainDate];
                    break;
                }
            }
            
            //在本月范围没有找到，那么在未来的某一个月
            if (notiDate==nil) {
                NSDateComponents* nextRemindDateComponents = [[NSDateComponents alloc] init];
                NSInteger month = begainComponents.month;
                NSInteger year = begainComponents.year;
                do {
                    month++;
                    if (month==13) {
                        year++;
                        month = 1;
                    }
                    getSortedIntDayArr(model.dayArr, intDayArr, &cnt, [self getNumberOfDaysInYear:year month:month]);
                    //只要cnt不为0，就是找到了
                } while (cnt==0);
                nextRemindDateComponents.year = year;
                nextRemindDateComponents.month = month;
                nextRemindDateComponents.day = intDayArr[0];
                nextRemindDateComponents.hour = hour;
                nextRemindDateComponents.minute = minute;
                nextRemindDateComponents.second = second;
                notiDate = [[NSCalendar currentCalendar] dateFromComponents:nextRemindDateComponents];
            }
            break;
        }
        case TodoDataModelRepeatModeYear: {
            NSInteger index;
            NSDictionary* begainDateDict = @{
                TodoDataModelKeyMonth:[NSString stringWithFormat:@"%ld",begainComponents.month],
                TodoDataModelKeyDay:[NSString stringWithFormat:@"%ld",begainComponents.day],
            };
            NSInteger year = begainComponents.year;
            NSDictionary<TodoDataModelKey,NSString*>* dateDict = nil;
            NSArray<NSDictionary<TodoDataModelKey,NSString*>*>* sortedArr = [self getSortedTimeIntervalOfYearBegain:model.dateArr year:year index:&index ofDate:begainDateDict];
            
            if (index==sortedArr.count) {
                //未来的某一年
                dateDict = nil;
            }else {
                dateDict = sortedArr[index];
                if (notiSecond < begainSecond) {
                    //不是今天
                    if ([dateDict isEqualToDictionary:begainDateDict]) {
                        if (index+1==sortedArr.count) {
                            //未来的某一年
                            dateDict = nil;
                        }else {
                            dateDict = sortedArr[index+1];
                        }
                    }
                }
            }
            
            //去未来的年份找
            if (dateDict==nil) {
                do {
                    year++;
                    sortedArr = [self getSortedTimeIntervalOfYearBegain:model.dateArr year:year index:&index ofDate:begainDateDict];
                } while (sortedArr.count==0);
                dateDict = [sortedArr firstObject];
                
            }
            NSDateComponents* nextRemindDateComponents = [[NSDateComponents alloc] init];
            nextRemindDateComponents.year = year;
            nextRemindDateComponents.month = dateDict[TodoDataModelKeyMonth].integerValue;
            nextRemindDateComponents.day = dateDict[TodoDataModelKeyDay].integerValue;
            nextRemindDateComponents.hour = hour;
            nextRemindDateComponents.minute = minute;
            nextRemindDateComponents.second = second;
            notiDate = [[NSCalendar currentCalendar] dateFromComponents:nextRemindDateComponents];
            break;
        }
    }
    
    if (notiDate==nil) {
        return -1;
    }else {
        return (long) notiDate.timeIntervalSince1970;
    }
}



//MARK: +++++++++++++++++++++工具方法++++++++++++++++++++++++++++
+ (void)getMaxDaysOfMonthInYear:(NSInteger)year day:(NSInteger*)days {
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.year = year;
    for (int i=1; i<13; i++) {
        components.month = i;
        NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:components];
        days[i] = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    }
}
+ (NSArray<NSDictionary<TodoDataModelKey,NSString*>*>*)getSortedTimeIntervalOfYearBegain:(NSArray<NSDictionary<TodoDataModelKey,NSString*>*>*) arr year:(NSInteger)year index:(NSInteger*)index ofDate:(NSDictionary<TodoDataModelKey,NSString*>*)dateDict{
    
    NSMutableArray<NSDictionary<TodoDataModelKey,NSString*>*>* resultArr = [arr mutableCopy];
    
    if (year%4!=0||(year%100==0&&year%400!=0)) {
        [resultArr removeObject:@{
            TodoDataModelKeyMonth:@"2",
            TodoDataModelKeyDay:@"29"
        }];
        [resultArr removeObject:@{
            TodoDataModelKeyMonth:@"02",
            TodoDataModelKeyDay:@"29"
        }];
    }
    int mark = 0;
    if (![resultArr containsObject:dateDict]) {
        [resultArr addObject:dateDict];
        mark = 1;
    }
    
    [resultArr sortUsingComparator:^NSComparisonResult(NSDictionary<TodoDataModelKey,NSString*>*  _Nonnull obj1, NSDictionary<TodoDataModelKey,NSString*>*  _Nonnull obj2) {
        int d1 = obj1[TodoDataModelKeyMonth].intValue*31 + obj1[TodoDataModelKeyDay].intValue;
        int d2 = obj2[TodoDataModelKeyMonth].intValue*31 + obj2[TodoDataModelKeyDay].intValue;
        if (d1 < d2) {
            return -1;
        }else {
            return d1 > d2;
        }
    }];
    *index = [resultArr indexOfObject:dateDict];
    if (mark==1) {
        [resultArr removeObject:dateDict];
    }
    
    return resultArr;
}
/// 获取某一个月的最大天数
+ (NSInteger)getNumberOfDaysInMonth:(NSDate*)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/// 获取某一个月的最大天数
+ (NSInteger)getNumberOfDaysInYear:(NSInteger)year month:(NSInteger)mont {
    NSDateComponents* com = [[NSDateComponents alloc] init];
    com.year = year;
    com.month = mont;
    NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:com];
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/// 将字符串形式的日数组，转化为int形式的日数组，同时对日的最大值进行限制
/// @param dayStrArr 字符串形式的日数组
/// @param cnt int形式的日数组的大小
/// @param maxDay 日的最大值(可以等)
void getSortedIntDayArr(NSArray<NSString*>* dayStrArr, NSInteger* intDayArr, NSInteger* cnt, NSInteger maxDay) {
    *cnt = dayStrArr.count;
    NSInteger i = 0;
    for (NSString* dayStr in dayStrArr) {
        intDayArr[i] = dayStr.intValue;
        i++;
    }
    //从小到大排序
    qsort_b(intDayArr, *cnt, sizeof(NSInteger), ^(const void* n1, const void* n2){
        if (*(NSInteger*)n1 < *(NSInteger*)n2) {
            return -1;
        }else {
            return *(NSInteger*)n1 > *(NSInteger*)n2;
        }
    });
    
    i = *cnt - 1;
    while (intDayArr[i] > maxDay&&i>-1) {
        i--;
    }
    *cnt = i + 1;
}

void getSortedChainaIntWeekArr(NSArray<NSString*>* weekStrArr, NSInteger* intWeekArr) {
    int i=0;
    for (NSString* weekStr in weekStrArr) {
        intWeekArr[i] = weekStr.intValue;
        i++;
    }
    
    qsort_b(intWeekArr, weekStrArr.count, sizeof(NSInteger), ^(const void* n1, const void* n2){
        if (*(NSInteger*)n1 < *(NSInteger*)n2) {
            return -1;
        }else {
            return *(NSInteger*)n1 > *(NSInteger*)n2;
        }
    });
    
}

//从[1, 2, ... 7]转化为[2, 3, ... 1]
//static inline int ChinaWeekToForeignWeek(int week) {
//    return week%7+1;
//}
//从[2, 3, ... 1]转化为[1, 2, ... 7]
static inline int ForeignWeekToChinaWeek(int week) {
    return (week+5)%7+1;
}

@end
