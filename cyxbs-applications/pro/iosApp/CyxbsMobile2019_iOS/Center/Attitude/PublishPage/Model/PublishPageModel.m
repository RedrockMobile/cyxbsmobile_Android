//
//  PublishPageModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishPageModel.h"

@implementation PublishPageModel

- (void)postTagWithTitle:(NSString *)title
              andChoices:(NSArray<NSString *> *)array
             withSuccess:(void(^)(void))success
                 Failure:(void(^)(void))failure {
    NSDictionary *param = @{
        @"title" : title,
        @"choices" : array
    };
    [HttpTool.shareTool
     request:Center_POST_AttitudePublishTag_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:param
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        if (success) {
            NSLog(@"发布投票成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure();
        }
        NSLog(@"发布投票失败");
    }];
}

@end
