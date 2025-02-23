//
//  AttitudeSelfPageModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//
/// 鉴权Model
#import "AttitudeSelfPageModel.h"
#import "AttitudeSelfPageItem.h"

@implementation AttitudeSelfPageModel
- (void)requestAttitudePermissionWithSuccess:(void(^)(NSArray *array))success
                                     Failure:(void(^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool
     request:Center_GET_AttitudePermission_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *dataArray = [NSMutableArray array];
        NSLog(@"%@",object);
        NSLog(@"%@",object[@"data"]);
        AttitudeSelfPageItem *item = [AttitudeSelfPageItem initWithDic:object[@"data"]];
        [dataArray addObject:item];
        if (success) {
            success(dataArray.copy);
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
