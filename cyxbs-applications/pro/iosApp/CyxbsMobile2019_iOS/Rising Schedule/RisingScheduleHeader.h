//
//  RisingScheduleHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/8/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef RisingScheduleHeader_h
#define RisingScheduleHeader_h

#pragma mark - API

// 学生课表
#define RisingSchedule_POST_stuSchedule_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-jwzx/kebiao"]

// 老师课表
#define RisingSchedule_POST_teaSchedule_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-teakb/api/teaKb"]

// 请求事务
#define RisingSchedule_POST_perTransaction_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-reminder/Person/getTransaction"]

// 添加事务
#define RisingSchedule_POST_addTransaction_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-reminder/Person/addTransaction"]

// 更改事务
#define RisingSchedule_POST_editTransaction_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-reminder/Person/editTransaction"]

// 删除事务
#define RisingSchedule_POST_deleteTransaction_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-reminder/Person/deleteTransaction"]

#pragma mark - User Default

#define RisingClassSchedule_classBegin_String @"RisingClassSchedule_classBegin"

#define RisingClassSchedule_nowWeek_Integer @"RisingClassSchedule_nowWeek"

#endif /* RisingScheduleHeader_h */
