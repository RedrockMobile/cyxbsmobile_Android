//
//  FoodRefreshModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodHeader.h"
#import "FoodRefreshModel.h"

@implementation FoodRefreshModel

- (void)getEat_area:(NSArray *)eat_areaArr getEat_num:(NSArray *)eat_numArr requestSuccess:(void (^)(void))success failure:(void (^)(NSError *_Nonnull))failure {
    NSDictionary *paramters = @{
            @"eat_area": eat_areaArr,
            @"eat_num": eat_numArr
    };

    [HttpTool.shareTool
     request:Center_POST_FoodRefresh_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:paramters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"🟢%@:\n%@", self.class, object);
        self.status = [object[@"status"] intValue];
        if (self.status == 10000) {
            NSDictionary *data = object[@"data"];
            self.eat_propertyAry = data[@"eat_property"];
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
