//
//  FeedBackModel.m
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/8/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "FeedBackModel.h"
// network
#import "HttpClient.h"

@implementation FeedBackModel

+ (void)getDataArySuccess:(void (^)(NSArray * _Nonnull))success
                  failure:(void (^)(void))failure {
    
    [HttpTool.shareTool
     request:Mine_GET_feedBackCenterHistoryList_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:@{@"product_id" : @1}
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSArray * feedbacks = object[@"data"][@"feedbacks"];
        NSMutableArray <FeedBackModel *> * mAry = [NSMutableArray array];
        for (NSDictionary * feedback in feedbacks) {
            FeedBackModel * model = [FeedBackModel mj_objectWithKeyValues:feedback];
            [mAry addObject:model];
            if (model.replied &&
                ![NSUserDefaults.standardUserDefaults valueForKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]]) {
                [NSUserDefaults.standardUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]];
            }
        }
        
        // 回复且未查看
        NSMutableArray * temp1 = [NSMutableArray array];
        for (FeedBackModel * model in mAry) {
            if (model.replied &&
                NO == [NSUserDefaults.standardUserDefaults valueForKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]]) {
                [temp1 addObject:model];
            }
        }
        [mAry removeObjectsInArray:temp1];
        
        for (int i = 0; i < temp1.count; i++) {
            for (int j = 1; j < temp1.count - i; j++) {
                FeedBackModel * model1 = temp1[j];
                FeedBackModel * model2 = temp1[j - 1];
                if ([model1.CreatedAt compare:model2.CreatedAt]) {
                    temp1[j] = model2;
                    temp1[j - 1] = model1;
                }
            }
        }
        
        // 未回复的反馈
        NSMutableArray * temp2 = [NSMutableArray array];
        for (FeedBackModel * model in mAry) {
            if (model.replied == NO) {
                [temp2 addObject:model];
            }
        }
        [mAry removeObjectsInArray:temp2];
        
        for (int i = 0; i < temp2.count; i++) {
            for (int j = 1; j < temp2.count - i; j++) {
                FeedBackModel * model1 = temp2[j];
                FeedBackModel * model2 = temp2[j - 1];
                if ([model1.CreatedAt compare:model2.CreatedAt]) {
                    temp2[j] = model2;
                    temp2[j - 1] = model1;
                }
            }
        }
        
        [temp1 appendObjects:temp2];
        
        // 已回复的反馈
        for (int i = 0; i < mAry.count; i++) {
            for (int j = 1; j < mAry.count - i; j++) {
                FeedBackModel * model1 = mAry[j];
                FeedBackModel * model2 = mAry[j - 1];
                if ([model1.CreatedAt compare:model2.CreatedAt]) {
                    mAry[j] = model2;
                    mAry[j - 1] = model1;
                }
            }
        }
        
        [temp1 appendObjects:mAry];
        if (success) {
            success([temp1 copy]);
        }
        
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure();
        }
    }];
    
//    [[HttpClient defaultClient]
//     requestWithPath:Mine_GET_feedBackCenterHistoryList_API
//     method:HttpRequestGet
//     parameters:@{@"product_id" : @1}
//     prepareExecute:nil
//     progress:nil
//     success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSArray * feedbacks = responseObject[@"data"][@"feedbacks"];
//        NSMutableArray <FeedBackModel *> * mAry = [NSMutableArray array];
//        for (NSDictionary * feedback in feedbacks) {
//            FeedBackModel * model = [FeedBackModel mj_objectWithKeyValues:feedback];
//            [mAry addObject:model];
//            if (model.replied &&
//                ![NSUserDefaults.standardUserDefaults valueForKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]]) {
//                [NSUserDefaults.standardUserDefaults setBool:NO forKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]];
//            }
//        }
//        
//        // 回复且未查看
//        NSMutableArray * temp1 = [NSMutableArray array];
//        for (FeedBackModel * model in mAry) {
//            if (model.replied &&
//                NO == [NSUserDefaults.standardUserDefaults valueForKey:[NSString stringWithFormat:@"feedback_history_%zd", model.ID]]) {
//                [temp1 addObject:model];
//            }
//        }
//        [mAry removeObjectsInArray:temp1];
//        
//        for (int i = 0; i < temp1.count; i++) {
//            for (int j = 1; j < temp1.count - i; j++) {
//                FeedBackModel * model1 = temp1[j];
//                FeedBackModel * model2 = temp1[j - 1];
//                if ([model1.CreatedAt compare:model2.CreatedAt]) {
//                    temp1[j] = model2;
//                    temp1[j - 1] = model1;
//                }
//            }
//        }
//        
//        // 未回复的反馈
//        NSMutableArray * temp2 = [NSMutableArray array];
//        for (FeedBackModel * model in mAry) {
//            if (model.replied == NO) {
//                [temp2 addObject:model];
//            }
//        }
//        [mAry removeObjectsInArray:temp2];
//        
//        for (int i = 0; i < temp2.count; i++) {
//            for (int j = 1; j < temp2.count - i; j++) {
//                FeedBackModel * model1 = temp2[j];
//                FeedBackModel * model2 = temp2[j - 1];
//                if ([model1.CreatedAt compare:model2.CreatedAt]) {
//                    temp2[j] = model2;
//                    temp2[j - 1] = model1;
//                }
//            }
//        }
//        
//        [temp1 appendObjects:temp2];
//        
//        // 已回复的反馈
//        for (int i = 0; i < mAry.count; i++) {
//            for (int j = 1; j < mAry.count - i; j++) {
//                FeedBackModel * model1 = mAry[j];
//                FeedBackModel * model2 = mAry[j - 1];
//                if ([model1.CreatedAt compare:model2.CreatedAt]) {
//                    mAry[j] = model2;
//                    mAry[j - 1] = model1;
//                }
//            }
//        }
//        
//        [temp1 appendObjects:mAry];
//        
//        success([temp1 copy]);
//    }
//     failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure();
//    }];
}

@end
