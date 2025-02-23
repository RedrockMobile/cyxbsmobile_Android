//
//  NSDate+Day.h
//  SSRSwipe
//
//  Created by SSR on 2022/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN const NSTimeInterval aDayTimeInterval;

UIKIT_EXTERN const NSTimeInterval aWeekTimeInterval;

#pragma mark - NSDate (Day)

@interface NSDate (Day)

/// 今天
+ (NSDate *)today;

/// 这天的前一天
- (NSDate *)yesterday;

/// 这天的后一天
- (NSDate *)tomorrow;

/// 通过dateStr和formatter一一对应获取date
+ (NSDate *)dateString:(NSString *)dateStr fromFormatter:(NSDateFormatter *)formatter withDateFormat:(NSString *)format;

/// 通过formate形式取出数据
- (NSString *)stringFromFormatter:(NSDateFormatter *)formatter withDateFormat:(NSString *)format;

/// 返回“第n周”或nil
/// @param week 传入星期
+ (NSString * _Nullable)stringForSchoolWeek:(NSInteger)week;

/// 如果是节日则返回节日，没有则为@""
- (NSString *)stringForFastival;

@end

#pragma mark - NSDateFormatter (NSDate)

@interface NSDateFormatter (NSDate)

/// 默认formatter
@property (nonatomic, readonly, strong, class) NSDateFormatter *defaultFormatter;

/// 中文formatter
@property (nonatomic, readonly, strong, class) NSDateFormatter *ChineseFormatter;

@end

NS_ASSUME_NONNULL_END
