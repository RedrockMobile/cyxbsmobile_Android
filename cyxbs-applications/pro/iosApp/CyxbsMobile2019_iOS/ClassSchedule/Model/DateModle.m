//
//  DateModle.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/30.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "DateModle.h"
#import "掌上重邮-Swift.h"

@implementation DateModle
+(instancetype)initWithStartDate {
    DateModle *dateModel = [[DateModle alloc]init];
    [dateModel initCalculateDate:[SwiftToOC getStartDate]];
    return dateModel;
}

- (NSNumber *)nowWeek {
    return  [NSNumber numberWithInteger:[SwiftToOC getNowWeek]];
}

-(void)initCalculateDate:(NSDate *)resDate{
    
    //初始化日期数组
    _dateArray = [[NSMutableArray alloc]init];
    
    for (int i = 1 ; i < 26; i++) {
        //建立临时数组，保存一个星期的数据
        NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
        
        for (int j = 0; j < 7; j++) {
            
            //每日的数据包装成一个字典，包含月和日
            NSDictionary *monthAndDay = [self getMonthAndDay:resDate];
            
            //将每日的数据添加到相应星期的临时数组里
            [tmpArray addObject:monthAndDay];
            
            resDate = [resDate dateByAddingDays:1];
        }
        
        //按星期保存
        [_dateArray addObject:tmpArray];
    }
    
}

-(NSDictionary *)getMonthAndDay:(NSDate *)date{
    //提取月、日
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|
    NSCalendarUnitDay;//获取日期的元素。
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    
    return @{
        @"month":[NSNumber numberWithLong:d.month],
        @"day":[NSNumber numberWithLong:d.day]
    };
}

//-(void)calculateNowWeek:(NSDate *)Date{
//    //计算当前是第几周
//    NSTimeInterval beginTime=[Date timeIntervalSinceReferenceDate];
//    NSDate *now = [NSDate date];
//    NSTimeInterval nowTime = [now timeIntervalSinceReferenceDate];
//
//    double day = (nowTime - beginTime)/604800.0;
//
//    NSInteger nowWeek = (int)ceil(day);
//
//    if(nowWeek < 0){
//        nowWeek = 0;
//    }
//    self.nowWeek = [NSNumber numberWithInteger:nowWeek];
//
//    //把当前的周数存入缓存
//    [NSUserDefaults.standardUserDefaults setValue:self.nowWeek.stringValue forKey:nowWeekKey_NSString];
//}
@end
