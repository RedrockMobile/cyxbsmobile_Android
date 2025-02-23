//
//  MineMainPageHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/28.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef MineMainPageHeader_h
#define MineMainPageHeader_h

#pragma mark - API

#define MineMainPage_GET_getFansAndFollowsInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/fansAndFollowsInfo"]

// 发动态
#define MineMainPage_GET_postDynamic_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/dynamic/user"]

#define MineMainPage_POST_deleteIdentity_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-identity/DeleteIdentity"]

// 获取信息
#define MineMainPage_GET_getInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/person/info"]
// 关注
#define MineMainPage_POST_focusUser_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/focus"]
// 换背景图片
#define MineMainPage_PUT_uploadBackground_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/person/background_url"]

// 修改信息
#define MineMainPage_Put_PersonInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/person/info"]
// 修改头像
#define MineMainPage_Put_UploadAvatar_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/person/upload/avatar"]

#endif /* MineMainPageHeader_h */
