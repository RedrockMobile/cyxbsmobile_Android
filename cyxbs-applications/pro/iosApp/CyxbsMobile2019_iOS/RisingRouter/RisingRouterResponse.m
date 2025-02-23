//
//  RisingRouterResponse.m
//  Rising
//
//  Created by SSR on 2022/7/18.
//

#import "RisingRouterResponse.h"

#pragma mark - RisingRouterResponse

@implementation RisingRouterResponse

- (NSString *)description {
    NSMutableString *string = NSMutableString.string;
    
    if (self.responseClass) {
        [string appendFormat:@"响应的类为: %@, ", self.responseClass];
    } else {
        [string appendString:@"无响应的类, "];
    }
    
    switch (self.errorCode) {
        case RouterResponseSuccess: {
            [string appendString:@"响应成功, "];
        } break;
        case RouterParameterLoss: {
            [string appendString:@"参数缺失, "];
        } break;
        case RouterParameterMatchFaild: {
            [string appendString:@"匹配失败, "];
        } break;
        case RouterParameterClassError: {
            [string appendString:@"类型错误, "];
        }
        case RouterParameterConflict: {
            [string appendString:@"参数互斥, "];
        } break;
        case RouterWithoutNavagation: {
            [string appendString:@"无栈管理, "];
        } break;
    }
    
    [string appendString:self.errorDescription];
    
    return string.copy;
}

@end
