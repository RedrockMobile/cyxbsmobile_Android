//
//  AttitudeMainModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/2/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AttitudeMainModel.h"
#import "AttitudeMainPageItem.h"

@implementation AttitudeMainModel

- (void)requestAttitudeDataWithOffset:(NSInteger)offset
                                Limit:(NSInteger)limit
                              Success:(void (^)(NSArray *array))success
                              Failure:(void (^)(NSError * _Nonnull))failure {
    
    NSDictionary *param = @{
        @"limit": [NSNumber numberWithLong:limit],
        @"offset": [NSNumber numberWithLong:offset]
    };
    [HttpTool.shareTool
     request:Center_GET_AttitudehomePage_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:param // offset参数未选默认为0，limit默认20
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSMutableArray *mutarray = [NSMutableArray array];
        for (NSDictionary *dic in object[@"data"]) {
            AttitudeMainPageItem *model = [AttitudeMainPageItem initWithDic:dic];
            [mutarray addObject:model];
        }
        if (success) {
            NSLog(@"==============主页success");
            success(mutarray.copy);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"=====================表态主页数据获取失败");
    }];
}



@end
