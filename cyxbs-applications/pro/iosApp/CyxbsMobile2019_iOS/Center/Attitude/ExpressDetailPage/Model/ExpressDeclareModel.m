//
//  ExpressDeclareModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressDeclareModel.h"
#import "ExpressDeclareItem.h"

@implementation ExpressDeclareModel

// 表态撤销投票。参数id
- (void)requestDeclareDataWithId:(NSNumber *)theId
                         Success:(void(^)(bool declareSuccess))success
                         Failure:(void(^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool
    form:Center_DELETE_AttitudeCancelPick_API
     type:HttpToolRequestTypeDelete
     parameters:nil
     bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
        //数据转二进制
        NSData *iData = [[theId stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        //往表单添加数据
        [body appendPartWithFormData:iData name:@"id"];
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSInteger status = [object[@"status"] intValue];
        if (status == 10000) {
            if (object[@"id"] == theId) {
                if (success) {
                    success(true);
                }
            }
        }
    } 
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
