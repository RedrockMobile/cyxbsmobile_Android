//
//  MineHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/24.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef MineHeader_h
#define MineHeader_h

// "我的"接口
#pragma mark - API

#define CyxbsMobileBaseURL_1 [NSUserDefaults.standardUserDefaults objectForKey:@"baseURL"]

/// 登录接口
#define Mine_POST_logIn_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/token"]

/// 登录时上传用户手机id，ip地址，生产厂商
#define Mine_POST_loginInformation_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/token/record"]

#pragma mark - Login
/// 刷新token
#define Mine_POST_refreshToken_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/token/refresh"]

/// 上传头像。未使用
#define Mine_GET_upLoadProfile_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/person/upload/avatar"]

/// 上传用户信息。未使用
#define Mine_GET_upLoadUserInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/Person/SetInfo"]

#pragma mark - 修改密码

/// 通过教务在线ids登录获取验证码
#define Mine_POST_UserSecretIds_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/valid/ids"]

/// 通过验证码更改密码
#define Mine_POST_SureChangePassword_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/password/valid"]

#pragma mark - CheckIn
/// 获取签到信息
#define Mine_POST_checkInInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/QA/User/getScoreStatus"]

/// 签到
#define Mine_POST_checkIn_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/QA/Integral/checkIn"]

/// 积分商城。未使用
#define Mine_GET_integralStoreList_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/QA/Integral/getItemList"]

/// 兑换商品。未使用
#define Mine_GET_integralStoreOrder_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/QA/Integral/order"]

/// 我的商品。未使用
#define Mine_GET_myGoodsList_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-intergral/QA/Integral/myRepertory"]

/// “我的”邮问数据。未使用
#define Mine_GET_mineQAData_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"QA/User/mine"]

/// 我的提问。未使用
#define Mine_GET_myQuestions_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"QA/User/question"]

/// 提问草稿箱。未使用
#define Mine_GET_myQuestionDraft_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-draft/User/getDraftQuestionList"]

/// 我的回答。未使用
#define Mine_GET_myAnswers_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"QA/User/answer"]

/// 回答草稿箱。未使用
#define Mine_GET_myAnswersDraft_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-draft/User/getDraftAnswerList"]

/// 发出的评论。未使用
#define Mine_GET_myComment_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"QA/User/comment"]

/// 收到的评论。未使用
#define Mine_GET_myRecomment_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"QA/User/reComment"]

/// 删除草稿。未使用
#define Mine_GET_deleteDraft_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-draft/User/deleteItemInDraft"]

#pragma mark - Setting-peopleignore
//取消屏蔽某人
#define Mine_POST_cancelIgnorePeople_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ignore/cancelIgnoreUid"]

//屏蔽某人
#define Mine_POST_ignorePeople_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/ignore/addIgnoreUid"]

#pragma mark - ArticleRemarkPraise
//删除帖子
#define Mine_POST_deleteArticle_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/comment/deleteId"]

//获取自己的帖子
#define Mine_GET_getArticle_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/getUserPostList"]

// 通过帖子id 获取帖子数据。未使用
#define Mine_GET_getPostInfo_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/post/getPostInfo"]

//动态/点赞/获赞评论数。未使用
#define Mine_GET_getUserCount_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/getUserCount"]

//未读消息数
#define Mine_GET_getMsgCnt_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/uncheckedMessage"]

//获取收到的评论
#define Mine_GET_getReply_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/replyme"]

//获取收到的赞
#define Mine_GET_getPraise_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/praisedme"]

#pragma mark - login
//获取用户资料，POST
#define Mine_POST_getPersonData_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke/Person/Search"]

#pragma mark - peopleignore
//获取屏蔽的人
#define Mine_POST_getIgnoreUid_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-loop/user/getIgnoreUid"]

#pragma mark - about
//获取用户服务协议
#define Mine_POST_getAboutUsMsg_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-text/text/get"]

#endif /* MineHeader_h */
