//
//  FoodPraiseModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodHeader.h"
#import "FoodPraiseModel.h"

@implementation FoodPraiseModel

- (void)getName:(NSString *)name requestSuccess:(void (^)(void))success failure:(void (^)(NSError *_Nonnull))failure {
    NSDictionary *paramters = @{
        @"name": name
    };

    [HttpTool.shareTool
     request:Center_POST_FoodPraise_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:paramters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"🟢%@:\n%@", self.class, object);
        self.status = [object[@"status"] intValue];
        if (self.status == 10000) {
            NSDictionary *data = object[@"data"];
            self.name = [NSString stringWithFormat:@"%@", data[@"name"]];
            self.pictureURL = [NSString stringWithFormat:@"%@", data[@"picture"]];
            self.introduce = [NSString stringWithFormat:@"%@", data[@"introduce"]];
            self.praise_num = [data[@"praise_num"] intValue];
            self.praise_is = [data[@"praise_is"] boolValue];
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
