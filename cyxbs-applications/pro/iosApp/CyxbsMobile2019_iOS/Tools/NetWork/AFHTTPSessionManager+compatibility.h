
//
//  AFHTTPSessionManager+compatibility.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2022/6/29.
//  Copyright © 2022 Redrock. All rights reserved.
//  为兼容旧版的 AFN API

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (compatibility)

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure DEPRECATED_ATTRIBUTE;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure DEPRECATED_ATTRIBUTE;

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure DEPRECATED_ATTRIBUTE;

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure DEPRECATED_ATTRIBUTE;

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString
                     parameters:(nullable id)parameters
                        success:(nullable void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure DEPRECATED_ATTRIBUTE;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                       success:(nullable void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure DEPRECATED_ATTRIBUTE;
@end

NS_ASSUME_NONNULL_END

/*
 Stove：
    AFN 的新版 API 中的某些回调（如 progress）对于掌邮来说使用上的概率极低，
 我们自己套皮一份（比如 AFHTTPSessionManager+compatibility 这种套皮）不带这种回调
 的 API，对开发者来说是更便利的。
 好处：便利，代码短一些
 坏处：脱离了带有套皮的环境的代码，无法独立运行
 
 但是其实大部分时候，使用的是我们自己封装的网络请求工具
 
 */
