//
//  RisingRouter+Extension.m
//  ByteDanceCampus_Weather
//
//  Created by SSR on 2022/7/25.
//

#import "RisingRouter+Extension.h"

#pragma mark - RisingRouter (UIViewController)

@implementation RisingRouter (UIViewController)

- (__kindof UIViewController *)controllerForRouterPath:(NSString *)routerPath {
    return [self controllerForRouterPath:routerPath parameters:nil];
}

- (__kindof UIViewController *)controllerForRouterPath:(NSString *)routerPath parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithRouterPath:routerPath parameters:parameters];
        request.requestType = RouterRequestController;
        __block UIViewController *vc;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            vc = response.responseController;
        }];
        return vc;
    }
}

- (__kindof UIViewController *)controllerForURL:(NSURL *)url {
    return [self controllerForURL:url parameters:nil];
}

- (__kindof UIViewController *)controllerForURL:(NSURL *)url parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithURL:url parameters:parameters];
        request.requestType = RouterRequestController;
        __block UIViewController *vc;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            vc = response.responseController;
        }];
        return vc;
    }
}

@end

#pragma mark - RisingRouter (UINavigationController)

@implementation RisingRouter (UINavigationController)

- (BOOL)pushForRouterPath:(NSString *)routerPath {
    return [self pushForRouterPath:routerPath parameters:nil];
}

- (BOOL)pushForRouterPath:(NSString *)routerPath parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithRouterPath:routerPath parameters:parameters];
        __block BOOL isPush;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            isPush = (response.errorCode != RouterWithoutNavagation);
        }];
        return isPush;
    }
}

- (BOOL)pushForURL:(NSURL *)url {
    return [self pushForURL:url parameters:nil];
}

- (BOOL)pushForURL:(NSURL *)url parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithURL:url parameters:parameters];
        __block BOOL isPush;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            isPush = (response.errorCode != RouterWithoutNavagation);
        }];
        return isPush;
    }
}

@end

#pragma mark - RisingRouter (Parameters)

@implementation RisingRouter (Parameters)

- (id)sourceForRouterPath:(NSString *)routerPath {
    return [self sourceForRouterPath:routerPath parameters:nil];
}

- (id)sourceForRouterPath:(NSString *)routerPath parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithRouterPath:routerPath parameters:parameters];
        request.requestType = RouterRequestParameters;
        __block id source;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            source = response.responseSource;
        }];
        return source;
    }
}

- (id)sourceForURL:(NSURL *)url {
    return [self sourceForURL:url parameters:nil];
}

- (id)sourceForURL:(NSURL *)url parameters:(NSDictionary *)parameters {
    @synchronized (self) {
        RisingRouterRequest *request = [RisingRouterRequest requestWithURL:url parameters:parameters];
        request.requestType = RouterRequestParameters;
        __block id source;
        [self
        handleRequest:request complition:^(RisingRouterRequest * _Nonnull request, RisingRouterResponse * _Nonnull response) {
            source = response.responseSource;
        }];
        return source;
    }
}

@end
