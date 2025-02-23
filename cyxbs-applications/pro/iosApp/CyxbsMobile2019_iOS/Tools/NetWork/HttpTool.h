//
//  HttpTool.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/5/5.
//  Copyright © 2022 Redrock. All rights reserved.
//

/**使用HttpTool.shareTool访问其单例对象
 * 一般情况下就用request，特殊POST单独用
 * header如果有需求，请在.m文件里
 * 对每个Serializer的Getter里面设置
 * - 不会在API后跟随parameters
 * - 所有parameters都在body内部
 * 请阅读 文档规范
 */

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

#import "RisingSingleClass.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ENUM (HttpToolRequest)

/**HttpToolRequestType请求类型
 * 开发前确定其type，最好是GET或POST
 */

typedef NS_ENUM(NSUInteger, HttpToolRequestType) {
    HttpToolRequestTypeGet,
    HttpToolRequestTypePost,
    HttpToolRequestTypeDelete,
    HttpToolRequestTypePut,
    HttpToolRequestTypePatch
};

#pragma mark - ENUM (HttpToolRequestSerializer)

/**HttpToolRequestSerializer请求体Body结构
 * 开发前确定其传上去的方式，最好是JSON或HTTP
 */

typedef NS_ENUM(NSUInteger, HttpToolRequestSerializer) {
    HttpToolRequestSerializerPropertyList,
    HttpToolRequestSerializerJSON,
    HttpToolRequestSerializerHTTP
};

#pragma mark - HttpTool

@interface HttpTool : NSObject

RisingSingleClass_PROPERTY(Tool)

- (instancetype)init NS_UNAVAILABLE;

/// 一般请求方式(dataTask请求)
/// @param URLString 请求URL全名
/// @param requestType 请求的类型
/// @param parameters 请求体(URI和Body请参考文档)
/// @param progress 进度(GET、POST独有)
/// @param success 请求成功返回
/// @param failure 请求失败返回
/// @param requestSerializer 拼接的格式
- (void)request:(NSString * _Nonnull)URLString
           type:(HttpToolRequestType)requestType
     serializer:(HttpToolRequestSerializer)requestSerializer
 bodyParameters:(id _Nullable)parameters
       progress:(nullable void (^)(NSProgress *progress))progress
        success:(nullable void (^)(NSURLSessionDataTask * task, id _Nullable object))success
        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * error))failure;

/// POST特殊请求(multipartForm请求)
/// @param URLString 请求URL全名
/// @param parameters 请求体(会转化并和后面的block一起)
/// @param block 一些特殊的对象转换
/// @param uploadProgress 上传进度
/// @param success 请求成功返回
/// @param failure 请求失败返回
- (void)form:(NSString * _Nonnull)URLString
        type:(HttpToolRequestType)requestType
  parameters:(nullable id)parameters
bodyConstructing:(nullable void (^)(id<AFMultipartFormData> body))block
    progress:(nullable void (^)(NSProgress * progress))uploadProgress
     success:(nullable void (^)(NSURLSessionDataTask * task, id _Nullable object))success
     failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * error))failure;

@end

#pragma mark - HttpTool (WKWebView)

@interface HttpTool (WKWebView)

- (NSURLRequest *)URLRequestWithURL:(NSString *)url
                     bodyParameters:(id _Nullable)parameters;

@end

NS_ASSUME_NONNULL_END
