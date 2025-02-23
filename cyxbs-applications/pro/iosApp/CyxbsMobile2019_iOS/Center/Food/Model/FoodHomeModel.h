//
//  FoodHomeModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/15.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 整体，在这里进行网络请求
@interface FoodHomeModel : NSObject

//状态码
@property (nonatomic, assign) NSInteger status;

///data中包含的
//图片URL
@property (nonatomic, copy) NSString *pictureURL;
//就餐区域
@property (nonatomic, copy) NSArray *eat_areaAry;
//就餐人数
@property (nonatomic, copy) NSArray *eat_numAry;
//餐饮特征，返回数量固定八个
@property (nonatomic, copy) NSArray *eat_propertyAry;

/// 网络请求
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
