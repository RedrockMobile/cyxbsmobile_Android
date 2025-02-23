//
//  SportAttendanceHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef SportAttendanceHeader_h
#define SportAttendanceHeader_h
#pragma mark - API

///查询前需要先绑定ids
#define Discover_POST_idsBinding_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/ids/bind"]

///体育打卡数据查询
#define Discover_GET_SportAttendance_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-sport/sport"]

#endif /* SportAttendanceHeader_h */
