//
//  ScorePageHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef ScorePageHeader_h
#define ScorePageHeader_h

#pragma mark - API

///查询绩点需要先绑定ids
#define Discover_POST_idsBinding_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/ids/bind"]

///绩点查询
#define Discover_GET_GPA_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/gpa"]

#endif /* ScorePageHeader_h */
