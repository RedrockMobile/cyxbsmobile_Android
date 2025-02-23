//
//  DetailsTaskModel.m
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsTaskModel.h"
// network
#import "HttpClient.h"

@implementation DetailsTaskModel

/// 正式环境
+ (void)getDataAryWithPage:(NSInteger)page
                      Size:(NSInteger)size
                   Success:(void (^)(NSArray * _Nonnull))success
                   failure:(void (^)(void))failure {
    NSDictionary * parameters = @{
        @"page" : @(page),
        @"size" : @(size)
    };
    
    [HttpTool.shareTool
     request:Mine_GET_stampStoreDetailsGetRecord_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:parameters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"success-task");
        NSMutableArray * mAry = [NSMutableArray array];
        for (NSDictionary * dict in object[@"data"]) {
            DetailsTaskModel * model = [DetailsTaskModel mj_objectWithKeyValues:dict];
            [mAry addObject:model];
        }
        NSArray * ary = [mAry copy];
        if (success) {
            success(ary);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-task");
        if (failure) {
            failure();
        }
    }];
    
    
//    [[HttpClient defaultClient] requestWithPath:Mine_GET_stampStoreDetailsGetRecord_API
//                                         method:HttpRequestGet
//                                     parameters:parameters
//                                 prepareExecute:nil
//                                       progress:nil
//                                        success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success-task");
//        NSMutableArray * mAry = [NSMutableArray array];
//        for (NSDictionary * dict in responseObject[@"data"]) {
//            DetailsTaskModel * model = [DetailsTaskModel mj_objectWithKeyValues:dict];
//            [mAry addObject:model];
//        }
//        NSArray * ary = [mAry copy];
//        success(ary);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure-task");
//        failure();
//    }];

}

@end
