//
//  RisingSingleClass.h
//  Rising
//
//  Created by SSR on 2022/9/17.
//

#ifndef RisingSingleClass_h
#define RisingSingleClass_h

#define RisingSingleClass_PROPERTY(name) +(instancetype)share##name;

#if __has_feature(objc_arc) // ARC

#define RisingSigleClass_IMPLEMENTATION(name)  \
static id _instance = nil; \
+ (instancetype)share##name { \
    return [[self alloc] init];\
} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[super allocWithZone:zone] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance; \
}

#else // MRC

#define RisingSingleClass_PROPERTY(name)  \
static name *_instance = nil; \
+ (instancetype)share##name { \
    name *instance = [[self alloc] init]; \
    return instance; \
} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[super allocWithZone:zone] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone { \
    return _instance; \
} \
- (oneway void)release { \
} \
- (instancetype)retain { \
    return _instance; \
} \
- (NSUInteger)retainCount { \
    return  MAXFLOAT; \
}

#endif

#endif /* RisingSigleClass_h */
