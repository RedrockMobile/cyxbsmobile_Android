//
//  CommonQuestionData.m
//  CyxbsMobile2019_iOS
//
//  Created by 钟文韬 on 2021/9/3.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "CommonQuestionData.h"

@implementation CommonQuestionData

+ (instancetype)CommonQuestionDataWithDict:(NSDictionary *)dict{
    CommonQuestionData *data = [[self alloc]init];
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (void)CommonQuestionDataWithSuccess:(void (^)(NSArray * _Nonnull))success error:(void (^)(void))error{
    
    [HttpTool.shareTool
     request:Mine_GET_commonQuestion_API
     type:HttpToolRequestTypeGet
     serializer:HttpToolRequestSerializerHTTP
     bodyParameters:nil
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSArray *array = object[@"data"];
    
        NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:99];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    CommonQuestionData *data = [self CommonQuestionDataWithDict:obj];
                    [mArray addObject:data];
                    
        }];
        if (success) {
            success(mArray.copy);
        }

    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"==========================出错了");
    }];
    
//    HttpClient *client = [HttpClient defaultClient];
//    [client requestWithPath:Mine_GET_commonQuestion_API method:HttpRequestGet parameters:nil prepareExecute:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSArray *array = responseObject[@"data"];
//        
//            NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:99];
//            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        CommonQuestionData *data = [self CommonQuestionDataWithDict:obj];
//                        [mArray addObject:data];
//                        
//            }];
//            success(mArray.copy);
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"==========================出错了");
//        }];
    
}
@end
