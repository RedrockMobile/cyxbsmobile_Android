//
//  MineMessageModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "MineMessageModel.h"

#pragma mark - MineMessageModel

@implementation MineMessageModel

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.systemMsgModel = [[SystemMsgModel alloc] init];
        self.activeMsgModel = [[ActiveMessageModel alloc] init];
    }
    return self;
}

- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [HttpTool.shareTool
     request:Discover_GET_allMsg_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP bodyParameters:nil progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSDictionary *data = object[@"data"];
        if (!data) {
            NSError *error = [[NSError alloc] init];
            failure(error);
            return;
        }
        self.systemMsgModel = [[SystemMsgModel alloc] initWithArray:data[@"system_msg"]];
        self.activeMsgModel = [[ActiveMessageModel alloc] initWithArray:data[@"active_msg"]];
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
