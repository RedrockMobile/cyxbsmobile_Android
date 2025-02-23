//
//  AttitudeHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

#ifndef AttitudeHeader_h
#define AttitudeHeader_h
// "表态"接口
#pragma mark - API

// 获取表态主页数据
#define Center_GET_AttitudehomePage_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare/homepage"]

// 获取表态页详细信息
#define Center_GET_AttitudeExpressDetail_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare"]

// 表态投票
#define Center_PUT_AttitudeExpressPick_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare"]

// 表态撤销投票
#define Center_DELETE_AttitudeCancelPick_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare"]
// 表态撤销投票(POST版)
#define Center_POST_AttitudeCancelPick_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare/delete"]

// 是否有权发布投票
#define Center_GET_AttitudePickPermission_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare/perm"]

// 获取自己发布的投票
#define Center_GET_AttitudeVotesData_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare/posts"]

// 发布投票
#define Center_POST_AttitudePublishTag_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare"]

// 鉴权
#define Center_GET_AttitudePermission_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-attitude/declare/perm"]

#endif /* AttitudeHeader_h */
