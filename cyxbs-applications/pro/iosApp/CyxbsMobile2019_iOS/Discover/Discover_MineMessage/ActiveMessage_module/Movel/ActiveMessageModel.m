//
//  ActiveMessageModel.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "ActiveMessageModel.h"

#import "HttpTool.h"

#pragma mark - ActiveMessageModel

@implementation ActiveMessageModel

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.activeMsgAry = NSMutableArray.array;
    }
    return self;
}

- (instancetype)initWithArray:(NSArray <NSDictionary *> *)ary {
    self = [super init];
    if (self && ![ary isKindOfClass:[NSNull class]]) {
        NSMutableArray <ActiveMessage *> *ma = NSMutableArray.array;
        for (NSDictionary *dic in ary) {
            ActiveMessage *msg = [[ActiveMessage alloc] initWithDictionary:dic];
            [ma addObject:msg];
        }
        self.activeMsgAry = ma.copy;
    }
    return self;
}

# pragma mark - Method

- (void)requestReadForIndexSet:(NSIndexSet *)set
                       success:(void (^)(void))success
                       failure:(void (^)(NSError *error))failure {
    NSMutableArray <NSString *> *idNums = NSMutableArray.array;
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        ActiveMessage *msg = self.activeMsgAry[idx];
        [idNums addObject:msg.otherThings];
        msg.hadRead = YES;
    }];
    NSDictionary <NSString *, NSArray <NSString *> *> *parameter = @{@"ids" : idNums.copy};
    
    // -- 网络请求：put 已读 --
    [HttpTool.shareTool
     request:Discover_PUT_hasRead_API
     type:HttpToolRequestTypePut
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:parameter
     progress:nil
     success:^(NSURLSessionDataTask * tast, id respon) {
        if (success) {
            success();
        }
    }
     failure:^(NSURLSessionDataTask * task, NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
