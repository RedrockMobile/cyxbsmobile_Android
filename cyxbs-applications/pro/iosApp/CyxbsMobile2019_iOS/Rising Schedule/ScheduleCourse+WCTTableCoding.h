//
//  ScheduleCourse+WCTTableCoding.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**ScheduleCourse (WCTTableCoding)
 * 这里列举了所有WCDB使用到的字段
 * WCDB业务将对这些字段进行改变
 * 而自己本身并不会对数据库进行操作
 */

#import "ScheduleCourse.h"

#import <WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduleCourse (WCTTableCoding) <
    WCTTableCoding
>

WCDB_PROPERTY(inWeek)
WCDB_PROPERTY(inSections)
WCDB_PROPERTY(period_location)
WCDB_PROPERTY(period_lenth)

WCDB_PROPERTY(course)
WCDB_PROPERTY(courseNike)
WCDB_PROPERTY(classRoom)
WCDB_PROPERTY(classRoomNike)

WCDB_PROPERTY(courseID)
WCDB_PROPERTY(rawWeek)
WCDB_PROPERTY(type)

WCDB_PROPERTY(sno)
WCDB_PROPERTY(teacher)
WCDB_PROPERTY(lesson)

@end

NS_ASSUME_NONNULL_END
