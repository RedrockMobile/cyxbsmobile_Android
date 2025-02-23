//
//  AliyunConfig.m
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/14.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "AliyunConfig.h"
#import <AlicloudHttpDNS/AlicloudHttpDNS.h>
#import <掌上重邮-Swift.h>

static HttpDnsService *httpdns = nil;

@implementation AliyunConfig

+ (NSString *)ipByHost:(NSString *)host {
    id res = [[AliyunConfig getHttpDNS] performSelector:@selector(getIpByHostAsyncInURLFormat:) withObject:host];
    if ([res isKindOfClass:NSString.class]) {
        return (NSString *)res;
    } else {
        return nil;
    }
}

+ (HttpDnsService *)getHttpDNS {
    if (httpdns == nil) {
        httpdns = [[HttpDnsService alloc] autoInit];
#if DEBUG
        [httpdns setLogEnabled:YES];
#endif
        [httpdns setExpiredIPEnabled:YES];
        [httpdns setPreResolveHosts:@[
            @"redrock.cqupt.edu.cn"
        ]];
    }
    return httpdns;
}

@end
