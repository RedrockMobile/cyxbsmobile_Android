//
//  SchoolBusData.m
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/4/7.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SchoolBusData.h"
#import <CommonCrypto/CommonCrypto.h>



@implementation SchoolBusData

+ (instancetype)SchoolBusDataWithDict:(NSDictionary *)dict{
    
    SchoolBusData *data = [[self alloc] init];
    data.latitude = [dict[@"lat"] doubleValue];
    data.longitude = [dict[@"lng"]doubleValue];
    data.busID = [dict[@"id"] intValue];
    data.type = [dict[@"type"] intValue];
    
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)SchoolBusDataWithSuccess:(void (^)(NSArray * _Nonnull))success error:(void (^)(void))errors{
    
    //当前时间转时间戳
    NSDate *nowDate = [NSDate date];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", (long)([nowDate timeIntervalSince1970]*1000)];
    timeStamp = [timeStamp substringToIndex:10];
    
    //MD5加密
    NSString *s = [self md5:[timeStamp stringByAppendingString:@".Redrock"]];
    NSString *t = timeStamp;
    NSString *r = [self md5:[NSString stringWithFormat:@"%d", [timeStamp intValue] - 1]];
    
    [HttpTool.shareTool
     form:Discover_POST_schoolBus_API
     type:HttpToolRequestTypePost
     parameters:nil
     bodyConstructing:^(id<AFMultipartFormData>  _Nonnull body) {
        //数据转二进制
        NSData *sData = [s dataUsingEncoding:NSUTF8StringEncoding];
        NSData *tData = [t dataUsingEncoding:NSUTF8StringEncoding];
        NSData *rData = [r dataUsingEncoding:NSUTF8StringEncoding];
        
        //往表单添加数据
        [body appendPartWithFormData:sData name:@"s"];
        [body appendPartWithFormData:tData name:@"t"];
        [body appendPartWithFormData:rData name:@"r"];
    }
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        //请求成功
        NSArray *array = object[@"data"][@"data"];
        NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:99];

        //字典转模型
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SchoolBusData *data = [self SchoolBusDataWithDict:obj];
            [mArray addObject:data];
        }];
        
        //调用成功的回调
        if (success) {
            success(mArray.copy);
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errors();
    }];
}

///MD5加密
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSMutableString *Mstr = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [Mstr appendFormat:@"%02x",result[i]];
    }
    return Mstr;
}


@end
