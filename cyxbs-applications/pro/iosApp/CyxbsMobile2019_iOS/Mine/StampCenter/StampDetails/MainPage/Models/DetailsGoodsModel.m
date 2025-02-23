//
//  DetailsgoodsModel.m
//  Details
//
//  Created by Edioth Jin on 2021/8/6.
//

#import "DetailsGoodsModel.h"
// network
#import "HttpClient.h"

@implementation DetailsGoodsModel

/// 正式环境网络请求
+ (void)getDataArySuccess:(void (^)(NSArray * array))success
                  failure:(void (^)(void))failure {
    
    [HttpTool.shareTool
     request:Mine_GET_stampStoreDetailsExchange_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"success-goods");
        NSMutableArray * mAry = [NSMutableArray array];
        for (NSDictionary * dict in object[@"data"]) {
            DetailsGoodsModel * model = [DetailsGoodsModel mj_objectWithKeyValues:dict];
            [mAry addObject:model];
        }
        NSArray * ary = [mAry copy];
        if (success) {
            success(ary);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-goods");
        if (failure) {
            failure();
        }
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_GET_stampStoreDetailsExchange_API
//                                         method:HttpRequestGet
//                                     parameters:nil
//                                 prepareExecute:nil
//                                       progress:nil
//                                        success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"success-goods");
//        NSMutableArray * mAry = [NSMutableArray array];
//        for (NSDictionary * dict in responseObject[@"data"]) {
//            DetailsGoodsModel * model = [DetailsGoodsModel mj_objectWithKeyValues:dict];
//            [mAry addObject:model];
//        }
//        NSArray * ary = [mAry copy];
//        success(ary);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure-goods");
//        failure();
//    }];
}

@end
