//
//  RisingRouterRequest.h
//  Rising
//
//  Created by SSR on 2022/7/12.
//

/// 这个RouterRequest用来解决Request的问题
/// 包括外链到内部的分配算法都在这里解决
/// TODO: 可以根据路径" / "一个一个push

#import <UIKit/UIKit.h>

#import "RisingUIKitExtension.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, RisingRouterRequestType) {
    RouterRequestPush,       // 默认，需要push
    RouterRequestController, // 不push，只要VC
    RouterRequestParameters, // 不是VC，只要参数
};

#pragma mark - RisingRouterRequest

@interface RisingRouterRequest : NSObject

#pragma mark Setter

/// 发出请求的Controller，如果为nil，有可能是不需要push
@property (nonatomic, weak, nullable) __kindof UIViewController *requestController;

/// 路由请求所抵达路径
@property (nonatomic, readonly) NSString *responsePath;

/// 请求的情况，默认为RouterRequestPush
@property (nonatomic) RisingRouterRequestType requestType;

#pragma mark Use

/// 使用顶层Controller，如果使用，请确定顶层VC有NavgationController
@property (nonatomic, readonly, nonnull, class) UIViewController *useTopController;

/// 请求发出的所有参数
@property (nonatomic, readonly, nullable) NSDictionary *parameters;

#pragma mark - Method

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

/// 外链转Request
/// @param url 只要一个URL就够了
+ (instancetype)requestWithURL:(NSURL *)url parameters:(NSDictionary *_Nullable)parameters;

/// 正常的一种Request
/// @param routerPath 路由路径
/// @param paramaters 路由参数
+ (instancetype)requestWithRouterPath:(NSString *)routerPath parameters:(NSDictionary * _Nullable)paramaters;

@end

NS_ASSUME_NONNULL_END
