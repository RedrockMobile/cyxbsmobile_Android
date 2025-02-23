//
//  FoodResultModel.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "FoodHeader.h"
#import "FoodResultModel.h"

@implementation FoodResultModel

- (void)getEat_area:(NSArray *)eat_areaArr
         getEat_num:(NSString *)eat_numArr
    getEat_property:(NSArray *)eat_propertyArr
     requestSuccess:(void (^)(void))success failure:(void (^)(NSError *_Nonnull))failure {
    NSDictionary *paramters = @{
            @"eat_area": eat_areaArr,
            @"eat_num": eat_numArr,
            @"eat_property": eat_propertyArr
    };
    
    [HttpTool.shareTool
     request:Center_POST_FoodResult_API
     type:HttpToolRequestTypePost
     serializer:HttpToolRequestSerializerJSON
     bodyParameters:paramters
     progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable object) {
        NSLog(@"🟢%@:\n%@", self.class, object);
        self.status = [object[@"status"] intValue];
        if (self.status == 10000) {
            //数组<里面全是字典>
            NSArray <NSDictionary *> *data = object[@"data"];
            NSSet <NSDictionary *> *set = [NSSet setWithArray:data];
            NSMutableArray <FoodDetailsModel *> *ma = NSMutableArray.array;
            for (NSDictionary *dic in set) {
                FoodDetailsModel *foodModel = [[FoodDetailsModel alloc] initWithDictionary:dic];
                [ma addObject:foodModel];
            }
            self.dataArr = ma.copy;
        }
        if (success) {
            success();
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"🔴%@:\n%@", self.class, error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
