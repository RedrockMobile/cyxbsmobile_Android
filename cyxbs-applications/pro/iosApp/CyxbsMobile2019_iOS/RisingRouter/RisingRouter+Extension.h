//
//  RisingRouter+Extension.h
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/25.
//

#import "RisingRouter.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - RisingRouter (UIViewController)

@interface RisingRouter (UIViewController)

- (__kindof UIViewController *)controllerForRouterPath:(NSString *)routerPath;

- (__kindof UIViewController *)controllerForRouterPath:(NSString *)routerPath parameters:(NSDictionary * _Nullable)parameters;

- (__kindof UIViewController *)controllerForURL:(NSURL *)url;

- (__kindof UIViewController *)controllerForURL:(NSURL *)url parameters:(NSDictionary * _Nullable)parameters;

@end

#pragma mark - RisingRouter (UINavigationController)

@interface RisingRouter (UINavigationController)

- (BOOL)pushForRouterPath:(NSString *)routerPath;

- (BOOL)pushForRouterPath:(NSString *)routerPath parameters:(NSDictionary * _Nullable)parameters;

- (BOOL)pushForURL:(NSURL *)url;

- (BOOL)pushForURL:(NSURL *)url parameters:(NSDictionary * _Nullable)parameters;

@end

#pragma mark - RisingRouter (Parameters)

@interface RisingRouter (Parameters)

- (id)sourceForRouterPath:(NSString *)routerPath;

- (id)sourceForRouterPath:(NSString *)routerPath parameters:(NSDictionary * _Nullable)parameters;

- (id)sourceForURL:(NSURL *)url;

- (id)sourceForURL:(NSURL *)url parameters:(NSDictionary * _Nullable)parameters;

@end

NS_ASSUME_NONNULL_END
