//
//  RisingRouter.m
//  Rising
//
//  Created by SSR on 2022/7/11.
//

#import "RisingRouter.h"

#import <objc/runtime.h>

/// 单例
static RisingRouter *_router;

#pragma mark - RisingRouter ()

@interface RisingRouter ()

/// 存储所有被路由的类
@property (nonatomic, strong) NSMutableDictionary <NSString *, Class> *moduleDic;

/// 请求对象
@property (nonatomic, weak) id requestObj;

@end

#pragma mark - RisingRouter

@implementation RisingRouter

#pragma mark - Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.moduleDic = NSMutableDictionary.dictionary;
        int count = objc_getClassList(NULL, 0);
        Class *classes = (Class *)malloc(sizeof(Class) * count);
        objc_getClassList(classes, count);
        Protocol *p_handler = @protocol(RisingRouterHandler);
        // ???: 存routerPath的方法是否有待加强
        for (int i = 0; i < count; ++i) {
            Class cls = classes[i];
            for (Class thisCls = cls; thisCls;
                thisCls = class_getSuperclass(thisCls)) {
                
                if (!class_conformsToProtocol(thisCls, p_handler)) {
                    continue;
                }
                
                NSArray <NSString *> *paths = [(id<RisingRouterHandler>)thisCls routerPath];
                for (NSString *routerPath in paths) {
                    self.moduleDic[routerPath] = thisCls;
                }
                
                break;
            }
        }
        if (classes) {
            free(classes);
        }
    }
    return self;
}

+ (RisingRouter *)router {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _router = [[RisingRouter alloc] init];
    });
    return _router;
}

#pragma mark - Method

- (void)handleRequest:(RisingRouterRequest *)request
           complition:(RisingRouterCompletionBlock)completion {
    
    if ([self.requestObj isKindOfClass:UIViewController.class] && !request.requestController) {
        request.requestController = self.requestObj;
    }
    
    Class <RisingRouterHandler> handlerObj = self.moduleDic[request.responsePath];
    
    if (handlerObj) {
        __block RisingRouterResponse *response;
        
        [handlerObj
         responseRequest:request
         completion:^(RisingRouterResponse *responseObj) {
            response = responseObj;
        }];
        
        if (completion) {
            completion(request, response);
        }
    } else {
        NSAssert(handlerObj, @"路由失败，无响应对象");
    }
}

@end

#pragma mark - NSObject (RisingRouter)

@implementation NSObject (RisingRouter)

- (RisingRouter *)router {
    RisingRouter *shareRouter = RisingRouter.router;
    shareRouter.requestObj = self;
    return shareRouter;
}

@end
