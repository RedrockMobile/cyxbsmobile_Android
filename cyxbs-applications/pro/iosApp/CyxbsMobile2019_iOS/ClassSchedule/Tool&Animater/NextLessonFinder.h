//
//  NextLessonFinder.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/9/1.
//  Copyright © 2020 Redrock. All rights reserved.
//用来寻找下一节课的工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NextLessonFinder : NSObject

/// 获取下一节课信息的方法
/// @param orderlySchedulArray 有序的整学期课表，结构同WYCClassAndRemindDataModel.orderlySchedulArray
/// @param nowWeek 当前时间在第几周，1代表第一周
+ (NSDictionary*)getNextLessonDataWithOSArr:(NSArray*)orderlySchedulArray andNowWeek:(int)nowWeek;
/**
    返回值的结构：
    @"classroomLabel"：教室地点
    @"classTimeLabel"：上课时间
    @"classLabel"：课程名称
    @"is"：是否有课的标志,1就是有课
    @"hash_lesson"：第几节大课，0代表第一节
    @"hash_day"：星期几，0代表星期一
    @"hash_week"：第几周，1代表第一周
*/
@end

NS_ASSUME_NONNULL_END
