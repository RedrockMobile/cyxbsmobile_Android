//
//  CustomSessionManager.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "CustomSessionManager.h"
#import "ReduceAFSecurityPolicy.h"

@implementation CustomSessionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.securityPolicy = [ReduceAFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    if (!challenge) {
        return;
    }
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    
    //获取原始域名host，用原始请求即可获取
    NSString *host = [self.requestSerializer.HTTPRequestHeaders valueForKey:@"Host"];
    if (!host) {
        host = self.baseURL.host;
    }
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:host]) {
            disposition = NSURLSessionAuthChallengeUseCredential;
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    // 对于其他的challenges直接使用默认的验证方案
    completionHandler(disposition, credential);
}

@end
