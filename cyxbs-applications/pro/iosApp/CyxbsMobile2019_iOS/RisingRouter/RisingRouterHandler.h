//
//  RisingRouterHandler.h
//  Rising
//
//  Created by SSR on 2022/7/11.
//

/// 被路由的模块需要遵守这个Protocol

#import <UIKit/UIKit.h>

#import "RisingFoundationExtension.h"

#import "RisingRouterRequest.h"

#import "RisingRouterResponse.h"

NS_ASSUME_NONNULL_BEGIN

/// 被路由的类可以选择回掉的Block，告知路由类相关的信息
typedef void(^RisingRouterResponseBlock)(RisingRouterResponse *response);

#pragma mark - RisingRouterHandler

@protocol RisingRouterHandler <NSObject>

@required

/// 作为被路由的名称，做到不重复，且在文档集中必须提及出来
@property (nonatomic, readonly, class) NSArray <NSString *> *routerPath;

+ (void)responseRequest:(RisingRouterRequest *)request completion:(_Nullable RisingRouterResponseBlock)completion;

@end

NS_ASSUME_NONNULL_END
