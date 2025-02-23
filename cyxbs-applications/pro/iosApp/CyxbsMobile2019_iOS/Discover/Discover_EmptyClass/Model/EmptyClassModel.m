//
//  EmptyClassModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/4/22.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "EmptyClassModel.h"

@implementation EmptyClassModel

+ (void)RequestEmptyClassDataWithParams:(NSDictionary *)params success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool
     request:ClassSchedule_POST_emptyClass_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:params
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
    
//    [[HttpClient defaultClient] requestWithPath:ClassSchedule_POST_emptyClass_API method:HttpRequestPost parameters:params prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        success(responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//    }];
}

@end
