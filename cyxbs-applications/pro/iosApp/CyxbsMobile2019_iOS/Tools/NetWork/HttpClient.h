//
//  HttpClient.h
//  Demo
//
//  Created by 李展 on 2016/11/13.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

/**事件
 * 2022.5.16 SSR 请使用HttpTool.shareTool
 */

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "AFHTTPSessionManager+compatibility.h"

typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestDelete,
    HttpRequestPut,
    HttpRequestPatch
};
typedef void (^PrepareExecuteBlock)(void);

@interface HttpClient : NSObject
@property(strong,nonatomic)AFHTTPSessionManager *httpSessionManager;
/* merge_error @property(strong,nonatomic)AFHTTPRequestOperationManager *httpRequestOperationManager;
 */

+ (HttpClient *)defaultClient;

//- (void)requestWithHead:(NSString *)url
//                 method:(NSInteger)method
//             parameters:(id)parameters
//                   head:(NSDictionary *)head
//         prepareExecute:(PrepareExecuteBlock) prepare
//               progress:(void (^)(NSProgress * progress))progress
//                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithPath:(NSString *)url
                 method:(HttpRequestType)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/*
 merge_error
 - (void)PUT:(NSString *)URLString
  parameters:(id)parameters
       image:(UIImage *)image
  imageField:(NSString *)imageField
 prepareExecute:(PrepareExecuteBlock) prepare
    progress:(void (^)(NSProgress * progress))progress
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
 */

- (void)requestWithJson:(NSString *)url
                 method:(HttpRequestType)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/*
 merge_error
 - (void)uploadImageWithJson:(NSString *)url
                      method:(NSInteger)method
                  parameters:(id)parameters imageArray:(NSArray<UIImage  *> *)imageArray imageNames:(NSArray<NSString *> *)imageNames
              prepareExecute:(PrepareExecuteBlock) prepare
                    progress:(void (^)(NSProgress * progress))progress
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
 */

- (void)cancelRequest;
///获取baseURL
- (void)baseUrlRequestSuccess:(void(^)(NSString *str))success;

- (void)logInWithStuNum:(NSString*)stuNum idnum:(NSString*)idNum success:(void(^_Nonnull)(NSString * _Nonnull refreshToken, NSString * _Nonnull token))success failure:(void(^_Nonnull)(void))failure;

@end
