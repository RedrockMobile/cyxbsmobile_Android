//
//  AttitudeSelfPageDataModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeSelfPageDataModel.h"
#import "AttitudeSelfPageDataItem.h"

@implementation AttitudeSelfPageDataModel

- (void)requestAttitudeDataWithOffset:(NSInteger)offset
                                Limit:(NSInteger)limit
                              Success:(void (^)(NSArray *array))success
                              Failure:(void (^)(NSError * _Nonnull))failure {
    NSDictionary *param = @{
        @"limit": [NSNumber numberWithLong:limit],
        @"offset": [NSNumber numberWithLong:offset]
    };
    [HttpTool.shareTool
     request:Center_GET_AttitudeVotesData_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:param // offset参数未选默认为0，limit默认20
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *mutarray = [NSMutableArray array];
        for (NSDictionary *dic in object[@"data"]) {
            AttitudeSelfPageDataItem *model = [AttitudeSelfPageDataItem initWithDic:dic];
            [mutarray addObject:model];
        }
        if (success) {
            success(mutarray.copy);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 没有参数时的偷懒测试方法
- (void)requestAttitudeDataWithSuccess:(void (^)(NSArray *array))success
                               Failure:(void (^)(NSError * _Nonnull))failure {
    [HttpTool.shareTool
     request:Center_GET_AttitudeVotesData_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *mutarray = [NSMutableArray array];
        for (NSDictionary *dic in object[@"data"]) {
            AttitudeSelfPageDataItem *model = [AttitudeSelfPageDataItem initWithDic:dic];
            [mutarray addObject:model];
        }
        if (success) {
            success(mutarray.copy);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"=====================个人中心数据获取失败");
    }];
}

@end
