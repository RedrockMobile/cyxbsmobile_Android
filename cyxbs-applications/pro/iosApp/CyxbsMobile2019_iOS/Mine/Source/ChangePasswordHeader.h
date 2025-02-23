//
//  ChangePasswordHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 小艾同学 on 2022/7/27.
//  Copyright © 2022 Redrock. All rights reserved.
//

#ifndef ChangePasswordHeader_h
#define ChangePasswordHeader_h

// 修改密码 接口
#pragma mark - API

/// 密保问题列表
#define Mine_GET_questionList_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/question"]
///修改密码(个人界面)
#define Mine_POST_changePassword_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/password/personal"]

///修改密码(登录界面)
#define Mine_POST_ressetPassword_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/password/valid"]

///发送绑定邮箱验证码
#define Mine_POST_sendEmailCode_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/email/code"]

///验证绑定邮箱验证码
#define Mine_POST_emailCode_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/email"]
///是否绑定信息
#define Mine_POST_bindingEmailAndQuestion_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/is"]
///上传密保消息
#define Mine_POST_sendQuestion_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/question"]

//找回密码

///获取密保问题
#define Mine_POST_getQuestion_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/question/detail"]
///判断密保是否正确
#define Mine_POST_checkQuestion_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/valid/question"]

///判断验证码是否正确
#define Mine_POST_checkEmailCode_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/valid/email"]
///发送验证码请求
#define Mine_POST_getEmailCode_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/valid/email/code"]
///请求密保邮箱账号
#define Mine_POST_getEmailDetail_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/bind/email/detail"]
///判断是否为默认密码
#define Mine_POST_ifOriginPassword_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"user-secret/user/judge/origin"]

#endif /* ChangePasswordHeader_h */
