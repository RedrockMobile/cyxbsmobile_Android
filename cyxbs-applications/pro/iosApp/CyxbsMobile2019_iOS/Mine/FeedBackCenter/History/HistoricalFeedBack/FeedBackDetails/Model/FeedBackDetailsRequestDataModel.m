//
//  FeedBackDetailsRequestDataModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackDetailsRequestDataModel.h"
// network
#import "HttpClient.h"

@implementation FeedBackDetailsRequestDataModel

+ (void)getDataAryWithFeedBackID:(long)feedback_id
                         Success:(void (^)(NSArray * _Nonnull))success
                         failure:(void (^)(void))failure {
    
//    HttpClient *client = [HttpClient defaultClient];
//    [client.httpSessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",FEED_BACK_TOKEN]  forHTTPHeaderField:@"authorization"];
//    [client.httpSessionManager GET:Mine_GET_feedBackCenterHistoryView_API
//                        parameters:@{
//                            @"feedback_id" : @(feedback_id),
//                            @"product_id" : @1
//                        }
//                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSMutableArray * mAry = [NSMutableArray array];
//
//        //
//        NSDictionary * feedback = responseObject[@"data"][@"feedback"];
//        FeedBackDetailsModel * model = [FeedBackDetailsModel mj_objectWithKeyValues:feedback];
//        [mAry addObject:model];
//
//        //
//        NSDictionary * reply = responseObject[@"data"][@"reply"];
//        FeedBackReplyModel * replyModel = [FeedBackReplyModel mj_objectWithKeyValues:reply];
//        if (replyModel && replyModel.ID != 0) {
//            [mAry addObject: replyModel];
//        }
//
//        success([mAry copy]);
//    }
//                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        failure();
//    }];
     

    [HttpTool.shareTool
     request:Mine_GET_feedBackCenterHistoryView_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{
        @"feedback_id" : @(feedback_id),
        @"product_id" : @1
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *mAry = [NSMutableArray array];

        NSDictionary *feedback = object[@"data"][@"feedback"];
        FeedBackDetailsModel *model = [FeedBackDetailsModel mj_objectWithKeyValues:feedback];
        [mAry addObject:model];

        NSDictionary *reply = object[@"data"][@"reply"];
        FeedBackReplyModel *replyModel = [FeedBackReplyModel mj_objectWithKeyValues:reply];
        if (replyModel && replyModel.ID != 0) {
            [mAry addObject: replyModel];
        }
        if (success) {
            success([mAry copy]);
        }
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure();
        }
    }];
    
//    [[HttpClient defaultClient] requestWithPath:Mine_GET_feedBackCenterHistoryView_API
//                                         method:HttpRequestGet
//                                     parameters:@{
//                                         @"feedback_id" : @(feedback_id),
//                                         @"product_id" : @1
//                                     }
//                                 prepareExecute:nil
//                                       progress:nil
//                                        success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray * mAry = [NSMutableArray array];
//
//        //
//        NSDictionary * feedback = responseObject[@"data"][@"feedback"];
//        FeedBackDetailsModel * model = [FeedBackDetailsModel mj_objectWithKeyValues:feedback];
//        [mAry addObject:model];
//
//        //
//        NSDictionary * reply = responseObject[@"data"][@"reply"];
//        FeedBackReplyModel * replyModel = [FeedBackReplyModel mj_objectWithKeyValues:reply];
//        if (replyModel && replyModel.ID != 0) {
//            [mAry addObject: replyModel];
//        }
//
//        success([mAry copy]);
//
//    }
//                                        failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure();
//    }];
}

@end
