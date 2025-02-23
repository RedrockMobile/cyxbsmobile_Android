//
//  EditMyInfoModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "EditMyInfoModel.h"
#import "MineMainPageHeader.h"

@implementation EditMyInfoModel

///修改信息
+ (void)uploadUserInfo:(NSDictionary *)userInfo
               success:(void (^)(NSDictionary * _Nonnull))success
               failure:(void (^)(NSError * _Nonnull))failure {
    
    NSMutableDictionary *formParams = [[NSMutableDictionary alloc] init];
    for (NSString *key in userInfo) {
        formParams[key] = userInfo[key];
    }
    
    [HttpTool.shareTool request:MineMainPage_Put_PersonInfo_API
                           type:HttpToolRequestTypePut
                     serializer:HttpToolRequestSerializerHTTP
                 bodyParameters:formParams
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if (success) {
            success(object);
        }
    }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

///修改头像
+ (void)uploadProfile:(UIImage *)profile
              success:(void (^)(NSDictionary * _Nonnull))success
              failure:(void (^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool form:MineMainPage_Put_UploadAvatar_API
                        type:HttpToolRequestTypePut
                  parameters:nil
            bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
        if (profile) {
            [body appendPartWithFileData:UIImagePNGRepresentation(profile) name:@"fold" fileName:[NSString stringWithFormat:@"%ld.png", [NSDate nowTimestamp]] mimeType:@"image/png"];
            [body appendPartWithFormData: UserItemTool.defaultItem.stuNum.dataValue name:@"stunum"];
        }
    }
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"%@",object);
        if (success) {
            success(object);
            NSLog(@"%@",object);
        }
    }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"%@",error);
    }];
    
}

@end
