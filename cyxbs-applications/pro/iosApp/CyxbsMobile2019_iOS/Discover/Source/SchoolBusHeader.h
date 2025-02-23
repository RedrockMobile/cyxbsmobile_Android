//
//  SchoolBusHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef SchoolBusHeader_h
#define SchoolBusHeader_h

#pragma mark - API

/// 校车位置
#define Discover_POST_schoolBus_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"schoolbus/status"]

//#define SCHOOLSTATIONAPI_DEV @"https://be-prod.redrock.cqupt.edu.cn/schoolbus/map/line"
#define Discover_GET_schoolStation_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"schoolbus/map/line"]

#endif /* SchoolBusHeader_h */
