//
//  BuyModel.m
//  CyxbsMobile2019_iOS
//
//  Created by p_tyou on 2021/9/5.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "BuyModel.h"

@implementation BuyModel

- (void)buyGoodsWithID:(NSString *)ID {
    
    NSDictionary *param = @{@"id":ID};
    
    [HttpTool.shareTool
     request:Mine_POST_stampStoreExchange_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:param
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        self->_Block(object[@"status"]);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure-exchange%@" ,error);
    }];
    
//    HttpClient *client = [HttpClient defaultClient];
//    
//    [client requestWithPath:Mine_POST_stampStoreExchange_API method:HttpRequestPost parameters:param prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        self->_Block(responseObject[@"status"]);
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"failure-exchange%@" ,error);
//    }];
    
}

@end
