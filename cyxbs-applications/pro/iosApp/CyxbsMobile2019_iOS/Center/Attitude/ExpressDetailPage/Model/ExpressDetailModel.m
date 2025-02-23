//
//  ExpressPickGetModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ExpressDetailModel.h"

@implementation ExpressDetailModel

// 获取表态页详细信息 参数id
- (void)requestDetailDataWithId:(NSNumber *)theId
                           Success:(void(^)(ExpressPickGetItem *model))success
                           Failure:(void(^)(NSError * _Nonnull))failure {
    NSDictionary *param = @{ @"id": theId };
    [HttpTool.shareTool
    request:Center_GET_AttitudeExpressDetail_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:param
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSInteger status = [object[@"status"] intValue];
        if (status == 10000) {
            ExpressPickGetItem *model = [[ExpressPickGetItem alloc] initWithDic:object[@"data"]];
            // 转换成百分比字符数组
            model.percentStrArray = [model votedPercentCalculateToString:model.getStatistic];
            [model votedPercenteCalculateToNSNumber:model.getStatistic];
            if (success) {
                success(model);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
