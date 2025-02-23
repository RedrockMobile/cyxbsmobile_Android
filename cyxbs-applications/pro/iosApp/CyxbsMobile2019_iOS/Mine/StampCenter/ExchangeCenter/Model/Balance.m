//
//  Balance.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "Balance.h"
#import <AFNetworking/AFNetworking.h>

@implementation Balance

+ (void)getDataDictWithBalance:(NSString *)goodsid Success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(void))failure {
    
    [HttpTool.shareTool
     request:Mine_GET_stampStoreMainPage_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"success-page");
        if (success) {
            success(object[@"data"]);
        }
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-page");
        if (failure) {
            failure();
        }
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_GET_stampStoreMainPage_API
//                                         method:HttpRequestGet
//                                     parameters:nil
//                                 prepareExecute:nil
//                                       progress:nil
//                                        success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success-page");
//        success(responseObject[@"data"]);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure-page");
//        failure();
//    }];
}

@end
