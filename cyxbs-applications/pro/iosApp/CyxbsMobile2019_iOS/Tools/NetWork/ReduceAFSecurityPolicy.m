//
//  ReduceAFSecurityPolicy.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/9/14.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ReduceAFSecurityPolicy.h"

@implementation ReduceAFSecurityPolicy

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust forDomain:(NSString *)domain {
    /*
     * 创建证书校验策略
     */
    NSMutableArray *policies = [NSMutableArray array];
    if (domain) {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)domain)];
    } else {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateBasicX509()];
    }
    /*
     * 绑定校验策略到服务端的证书上
     */
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);
    /*
     * 评估当前serverTrust是否可信任，
     * 官方建议在result = kSecTrustResultUnspecified 或 kSecTrustResultProceed
     * 的情况下serverTrust可以被验证通过，https://developer.apple.com/library/ios/technotes/tn2232/_index.html
     * 关于SecTrustResultType的详细信息请参考SecTrust.h
     *
     * iOS 13 更新:使用SecTrustEvaluateWithError
     */
//    SecTrustResultType result;
//    SecTrustEvaluate(serverTrust, &result);
//    return (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
    
    return SecTrustEvaluateWithError(serverTrust, nil);
    

}


@end
