//
//  FoodResultModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FoodResultModel : NSObject

//状态码
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong, nonnull) NSArray <FoodDetailsModel *> *dataArr;

- (void)getEat_area:(NSArray *)eat_areaArr
         getEat_num:(NSString *)eat_numArr
    getEat_property:(NSArray *)eat_propertyArr
     requestSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
