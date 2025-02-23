//
//  RisingRouterResponse.h
//  Rising
//
//  Created by SSR on 2022/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ENUM (RisingRouterResponseError)

typedef NS_ENUM(NSUInteger, RisingRouterResponseError) {
    RouterResponseSuccess,      // 成功响应
    
    RouterParameterLoss,        // 参数缺失
    RouterParameterMatchFaild,  // 匹配失败
    RouterParameterClassError,  // 类型错误
    RouterParameterConflict,    // 参数互斥
    
    RouterWithoutNavagation     // 无栈管理
};

#pragma mark - RisingRouterResponse

@interface RisingRouterResponse : NSObject

/// 响应的类
@property (nonatomic, nullable) Class responseClass;

/// 响应的VC，可用于不push，而是要显示这个VC所使用
@property (nonatomic, nullable) __kindof UIViewController *responseController;

/// 错误代码，默认RouterResponseSuccess
@property (nonatomic) RisingRouterResponseError errorCode;

/// 错误描述
@property (nonatomic, copy) NSString *errorDescription;

/// 响应的资源
@property (nonatomic, nullable) id responseSource;

@end

NS_ASSUME_NONNULL_END
