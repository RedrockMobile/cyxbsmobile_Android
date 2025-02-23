//
//  NSDate+Day.m
//  SSRSwipe
//
//  Created by SSR on 2022/3/29.
//

#import "NSDate+Day.h"

const NSTimeInterval aDayTimeInterval = 24 * 60 * 60;

const NSTimeInterval aWeekTimeInterval = 7 * 24 * 60 * 60;

#pragma mark - NSDate (Day)

@implementation NSDate (Day)

+ (NSDate *)today {
    return  [NSDate date];
}

- (NSDate *)yesterday {
    return [self dateByAddingTimeInterval:- 24 * 60 * 60];
}

- (NSDate *)tomorrow {
    return [self dateByAddingTimeInterval:24 * 60 * 60];
}

+ (NSDate *)dateString:(NSString *)dateStr fromFormatter:(NSDateFormatter *)formatter withDateFormat:(NSString *)format {
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateStr];
}

- (NSString *)stringFromFormatter:(NSDateFormatter *)formatter withDateFormat:(NSString *)format {
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSString * _Nullable)stringForSchoolWeek:(NSInteger)week {
    NSArray *weekArray = @[@"整学期", @"第一周", @"第二周", @"第三周", @"第四周", @"第五周", @"第六周", @"第七周", @"第八周", @"第九周", @"第十周", @"第十一周", @"第十二周", @"第十三周", @"第十四周", @"第十五周", @"第十六周", @"第十七周", @"第十八周", @"第十九周", @"第二十周", @"第二十一周", @"第二十二周", @"第二十三周", @"第二十四周", @"第二十五周"];
    return (week >= 22 || week < 0) ? @"放假诶～" : weekArray[week];
}

- (NSString *)stringForFastival {
    NSDictionary *lunDic = @{
         @"0101":@"元旦",
         @"0308":@"妇女节",
         @"0312":@"植树节",
         @"0501":@"劳动节",
         @"0601":@"儿童节",
         @"0801":@"建军节",
         @"0910":@"教师节",
         @"1001":@"国庆节",
         @"1024":@"程序员日"
    };
    NSString *md = [self stringFromFormatter:NSDateFormatter.defaultFormatter withDateFormat:@"MMdd"];
    return lunDic[md] ? lunDic[md] : @"";
}

@end

#pragma mark - NSDateFormatter (NSDate)

static NSDateFormatter *_defaultFormatter = nil;
static NSDateFormatter *_chineseFormatter = nil;

@implementation NSDateFormatter (NSDate)

+ (NSDateFormatter *)defaultFormatter {
    if (_defaultFormatter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _defaultFormatter = [[NSDateFormatter alloc] init];
        });
    }
    return _defaultFormatter;
}

+ (NSDateFormatter *)ChineseFormatter {
    if (_chineseFormatter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _chineseFormatter = [[NSDateFormatter alloc] init];
            _chineseFormatter.monthSymbols =
            @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
            _chineseFormatter.shortMonthSymbols =  @[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"十二"];
            
            _chineseFormatter.veryShortMonthSymbols = _chineseFormatter.veryShortStandaloneMonthSymbols =  _chineseFormatter.shortMonthSymbols;
            
            _chineseFormatter.standaloneMonthSymbols = _chineseFormatter.shortStandaloneMonthSymbols = _chineseFormatter.monthSymbols;
            
            _chineseFormatter.weekdaySymbols = @[@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
            _chineseFormatter.shortWeekdaySymbols = @[@"周天", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
            _chineseFormatter.veryShortWeekdaySymbols = @[@"天", @"一", @"二", @"三", @"四", @"五", @"六"];
            _chineseFormatter.AMSymbol = @"上午";
            _chineseFormatter.PMSymbol = @"下午";
        });
    }
    return _chineseFormatter;
}

@end
