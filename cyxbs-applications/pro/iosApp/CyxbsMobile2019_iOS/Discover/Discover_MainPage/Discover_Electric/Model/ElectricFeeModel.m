//
//  ElectricFeeModel.m
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/10/28.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import "ElectricFeeModel.h"

@implementation ElectricFeeModel

- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError * _Nonnull))failure  {
    //缓存中有寝室号和寝室楼号就直接查询,否则传空试图从后端获取
    NSDictionary *parameters = ([UserItemTool defaultItem].building && [UserItemTool defaultItem].room) ?
        @{
            @"building": [UserItemTool defaultItem].building, @"room": [UserItemTool defaultItem].room
        } : @{
            @"building": @"", @"room": @""
    };
    
    [HttpTool.shareTool
     request:Discover_POST_electricFee_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:parameters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"%@",object);
        self.status = [object[@"status"] intValue];
        if(self.status == 200 ){
            self.electricFeeItem = [[ElectricFeeItem alloc] initWithDict:object];
        }else{
            NSLog(@"🔴%@:\n%@", self.class, object[@"info"]);
        }
        if (success) {
            success();
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"🔴%@:\n%@", self.class, error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
