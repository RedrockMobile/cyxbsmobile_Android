//
//  changePassword.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/2.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "changePassword.h"

@implementation changePassword

- (void)changePasswordWithNewPassword:(NSString *)password :(NSString *)stuId :(NSString *)code{
    if([NSUserDefaults.standardUserDefaults stringForKey:@"idNum"] != nil){
        NSDictionary *param = @{@"origin_password":[NSUserDefaults.standardUserDefaults stringForKey:@"idNum"],@"new_password":password};
        
        [HttpTool.shareTool
         request:Mine_POST_changePassword_API
         type:HttpToolRequestTypePost
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:param
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            self->_Block(object);
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败了");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToChangePassword" object:nil userInfo:nil];
        }];
        
//        HttpClient *client = [HttpClient defaultClient];
//        [client requestWithPath:Mine_POST_changePassword_API method:HttpRequestPost parameters:param prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                self->_Block(responseObject);
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"失败了");
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToChangePassword" object:nil userInfo:nil];
//        }];
    }
    else {
        NSDictionary *param = @{@"stu_num":stuId,@"new_password":password,@"code":code};
        
        [HttpTool.shareTool
         request:Mine_POST_ressetPassword_API
         type:HttpToolRequestTypePost
         serializer:HttpToolRequestSerializerHTTP
         bodyParameters:param
         progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
            self->_Block(object);
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败了");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToChangePassword" object:nil userInfo:nil];
        }];
        
//        HttpClient *client = [HttpClient defaultClient];
//        [client requestWithPath:Mine_POST_ressetPassword_API method:HttpRequestPost parameters:param prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                self->_Block(responseObject);
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"失败了");
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToChangePassword" object:nil userInfo:nil];
//        }];
    }
    
}

@end
