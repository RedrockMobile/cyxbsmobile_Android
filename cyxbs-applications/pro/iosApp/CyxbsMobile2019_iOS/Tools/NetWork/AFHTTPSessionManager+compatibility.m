//
//  AFHTTPSessionManager+compatibility.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2022/6/29.
//  Copyright © 2022 Redrock. All rights reserved.
//  为兼容旧版的 AFN API

#import "AFHTTPSessionManager+compatibility.h"

@implementation AFHTTPSessionManager (compatibility)

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self GET:URLString parameters:parameters headers:nil progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self POST:URLString parameters:parameters headers:nil progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self PUT:URLString parameters:parameters headers:nil success:success failure:failure];
}
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self DELETE:URLString parameters:parameters headers:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(nullable id)parameters
                        success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self PATCH:URLString parameters:parameters headers:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self POST:URLString parameters:parameters headers:nil constructingBodyWithBlock:block progress:nil success:success failure:failure];
    
}

@end
