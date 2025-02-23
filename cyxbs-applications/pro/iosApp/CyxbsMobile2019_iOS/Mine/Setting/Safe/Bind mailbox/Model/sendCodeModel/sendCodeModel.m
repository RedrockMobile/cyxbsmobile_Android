//
//  sendCodeModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "sendCodeModel.h"

@implementation sendCodeModel

- (void)sendCode:(NSString *)code ToEmail:(NSString *)email{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = .8f;
//    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
//    [responseSerializer setRemovesKeysWithNullValues:YES];
//    [responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
//
//    manager.responseSerializer = responseSerializer;
//
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [UserItemTool defaultItem].token]  forHTTPHeaderField:@"Authorization"];
//
    NSDictionary *param = @{@"email":email,@"code":code};
    
    [HttpTool.shareTool
     request:Mine_POST_emailCode_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:param
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        self->_Block(object);
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToBindingEmail" object:nil userInfo:nil];
    }];
    
//    [manager POST:Mine_POST_emailCode_API parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        self->_Block(responseObject);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"NoNetWorkToBindingEmail" object:nil userInfo:nil];
//    }];
 
    
}


@end
