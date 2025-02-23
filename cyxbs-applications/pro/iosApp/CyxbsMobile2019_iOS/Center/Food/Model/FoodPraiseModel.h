//
//  FoodPraiseModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodPraiseModel : NSObject
//状态码
@property (nonatomic, assign) NSInteger status;

///data中包含的
//食物名字
@property (nonatomic, copy) NSString *name;
//图片URL
@property (nonatomic, copy) NSString *pictureURL;
//食物介绍
@property (nonatomic, copy) NSString *introduce;
//点赞次数
@property (nonatomic, assign) NSInteger praise_num;
//是否点赞
@property (nonatomic, assign) bool praise_is;

- (void)getName:(NSString *)name requestSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
