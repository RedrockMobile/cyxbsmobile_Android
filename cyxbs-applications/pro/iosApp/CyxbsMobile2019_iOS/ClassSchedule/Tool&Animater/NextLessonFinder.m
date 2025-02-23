//
//  NextLessonFinder.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/9/1.
//  Copyright © 2020 Redrock. All rights reserved.
//用来寻找下一节课的工具类

#import "NextLessonFinder.h"

@implementation NextLessonFinder

+ (NSDictionary*)getNextLessonDataWithOSArr:(NSArray*)orderlySchedulArray andNowWeek:(int)nowWeek{
    NSDictionary *nextLessonData = [self transformDataWithDict:[self getCurrentTime]];
    
    //下节课在（第nowWeek周）的（星期hash_day+1）的（第hash_lesson节大课）
    int hash_week,hash_day,hash_lesson;
    hash_week = nowWeek+[nextLessonData[@"isNextWeek"] intValue];
    hash_day = [nextLessonData[@"hash_day"] intValue];
    hash_lesson = [nextLessonData[@"hash_lesson"]intValue];
    
    NSArray *lesson = nil;
    for (; hash_week<25; hash_week++) {
        for (; hash_day<7; hash_day++){
            for (; hash_lesson<6; hash_lesson++) {
                if([orderlySchedulArray[hash_week][hash_day][hash_lesson] count]!=0){
                    lesson = orderlySchedulArray[hash_week][hash_day][hash_lesson];
                    //找到下一节课后，用goto跳出3层循环
                    goto WYCClassBookViewControllerGetNextLessonDataBreak;
                }
            }
            hash_lesson = 0;
        }
        hash_day = 0;
    }
    hash_week = 0;
    
    //上面那个三层循环在找到下一节课后会用goto打断3层循环，跳到这里
WYCClassBookViewControllerGetNextLessonDataBreak:;
    NSDictionary *dataDict;
    if(lesson!=nil){
        NSDictionary *lessondata = [lesson firstObject];
        int period = [lessondata[@"period"] intValue];
        
        NSArray *timeStrArray = [self getTimeStrArrayWithPeriod:period];
        dataDict =  @{
                @"classroomLabel":lessondata[@"classroom"],
                @"classTimeLabel":timeStrArray[hash_lesson],
                @"classLabel":lessondata[@"course"],
                @"is":@"1",//是否有课的标志
                @"hash_lesson":[NSNumber numberWithInt:hash_lesson],
                @"hash_day":[NSNumber numberWithInt:hash_day],
                @"hash_week":[NSNumber numberWithInt:hash_week],
        };
    }else{
        //没课了
        dataDict = @{
            @"is":@"0",
        };
    }
    return dataDict;
}

/**
    返回的字典的结构：@{
    @"H":时,[0, 23]
    @"m:分"
    @"e":周几，2～周一，1~周日，4～周3
    };
*/
//获取当前时间信息的方法
+ (NSDictionary *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSArray *array = @[@"m",@"e",@"H"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *str in array) {
        [formatter setDateFormat:str];
        [dict setValue:[formatter stringFromDate:[NSDate date]]forKey:str];
    }
    return dict;
}

/**
    返回值结构：@{
    @"hash_day":星期hash_day+1,
    @"hash_lesson":第hash_lesson节大课
    @"isNextWeek"
    }
 */
//由当前的时间信息，推出下一节课在什么时候的方法，这里的下一节课可能是无课
+ (NSDictionary*)transformDataWithDict:(NSDictionary*)dataDict{
    int week = [dataDict[@"e"] intValue],hour = [dataDict[@"H"] intValue],min = [dataDict[@"m"] intValue];
    
    int totalMin = hour*60+min;
    int a1[] = {6,0,1,2,3,4,5};
    int isNextWeek=0;//用来表示下一节课是否在下周是
    NSString *hash_day = [NSString stringWithFormat:@"%d",a1[week-1]],*hash_lesson;
    
    //这里只能用if语句来从时间推知下一节课是什么时候，不过已经用了二分查找
    if(totalMin<840){//14:00以前
        if(totalMin<480){//0:00-8:00
            hash_lesson = @"0";
        }else if(totalMin<615){//8:00-10:15
            hash_lesson = @"1";
        }else{//10:15-14;00
            hash_lesson = @"2";
        }
    }else
        if(totalMin<1240){
            if(totalMin<975){//14:00-16:15
                hash_lesson = @"3";
            }else if(totalMin<1140){//16:15-19:00
                hash_lesson = @"4";
            }else{//19:00-20:40
                hash_lesson = @"5";
            }
        }else{//20:40-23:59
            if(a1[week-1]==6){//代表是周日的20:40以后，所以下一节课在周一
                hash_day = @"0";
                isNextWeek = 1;
            }else{//非周日的20:40以后的下一节课是明天
                hash_day = [NSString stringWithFormat:@"%d",a1[week-1]+1];
            }
            hash_lesson = @"0";
        }
    
    return @{
        @"hash_day":hash_day,
        @"hash_lesson":hash_lesson,
        @"isNextWeek":[NSString stringWithFormat:@"%d",isNextWeek],
    };
}
+ (NSArray*)getTimeStrArrayWithPeriod:(int)period{
    NSString *str12,*str56,*str910;
    switch (period) {
        case 2:
            str12 = @"8:00-9:40";
            str56 = @"14:00-16:15";
            str910 = @"19:00-20:40";
            break;
        case 3:
            str12 = @"8:00-11:00";
            str56 = @"14:00-17:00";
            str910 = @"19:00-21:35";
            break;
        case 4:
            str12 = @"8:00-11:55";
            str56 = @"14:00-17:55";
            str910 = @"19:00-22:30";
            break;
        default:
            break;
    }
    return @[str12,@"10:15 - 11:55",str56,@"16:15 - 17:55",str910,@"20:50 - 22:30"];
}
@end
