//
//  FoodHomeModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/15.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodHeader.h"
#import "FoodHomeModel.h"

@implementation FoodHomeModel

- (instancetype)init {
    self = [super init];
    return self;
}

- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError *_Nonnull))failure {
    [HttpTool.shareTool
     request:Center_GET_FoodHomePage_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"🟢%@:\n%@", self.class, object);
        self.status = [object[@"status"] intValue];
        if (self.status == 10000) {
            NSDictionary *data = object[@"data"];
            self.pictureURL = data[@"picture"];
            self.eat_areaAry = data[@"eat_area"];
            self.eat_numAry = data[@"eat_num"];
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
