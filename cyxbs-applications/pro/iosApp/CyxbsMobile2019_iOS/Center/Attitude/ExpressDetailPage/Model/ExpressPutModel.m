//
//  ExpressPickPutModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressPutModel.h"

@implementation ExpressPutModel

// 表态投票 body参数id，choices
- (void)requestPutDataWithId:(NSNumber *)theID
                       Choice:(NSString *)choice
                               Success:(void(^)(ExpressPickPutItem *model))success
                               Failure:(void(^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool
     form:Center_PUT_AttitudeExpressPick_API
     type:HttpToolRequestTypePut 
     parameters:nil
     bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
        //数据转二进制
        NSData *cData = [choice dataUsingEncoding:NSUTF8StringEncoding];
        NSData *iData = [[theID stringValue] dataUsingEncoding:NSUTF8StringEncoding];
        //往表单添加数据
        [body appendPartWithFormData:iData name:@"id"];
        [body appendPartWithFormData:cData name:@"choice"];
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSInteger status = [object[@"status"] intValue];
        if (status == 10000) {
            ExpressPickPutItem *pickModel = [[ExpressPickPutItem alloc] initWithDictionary:object[@"data"]];
            [pickModel votedPercenteCalculateToNSNumber:pickModel.putStatistic];
            pickModel.percentStrArray = [pickModel votedPercentCalculateToString:pickModel.putStatistic];
            if (success) {
                success(pickModel);
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
