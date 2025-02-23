//
//  Goods.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/8/13.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "Goods.h"
#import <AFNetworking/AFNetworking.h>
#import "HttpClient.h"

@implementation Goods

///网络请求
+ (void)getDataDictWithId:(NSString *)goodsid Success:(void (^)(NSDictionary * _Nonnull))success failure:(void (^)(void))failure {
    
    NSDictionary *paramDict = @{
        @"id":goodsid
    };
    
    [HttpTool.shareTool
     request:Mine_GET_stampStoreGoods_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:paramDict
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"success-goods");
        if (success) {
            success(object[@"data"]);
        }

    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-goods");
        if (failure) {
            failure();
        }
    }];
//    [[HttpClient defaultClient] requestWithPath:Mine_GET_stampStoreGoods_API
//                                         method:HttpRequestGet
//                                     parameters:paramDict
//                                 prepareExecute:nil
//                                       progress:nil
//                                        success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success-goods");
//        success(responseObject[@"data"]);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure-goods");
//        failure();
//    }];
    
}
@end
