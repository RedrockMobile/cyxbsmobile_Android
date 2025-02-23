//
//  FoodDetailsModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/25.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoodDetailsModel : NSObject

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
@property (nonatomic, assign) BOOL praise_is;

- (instancetype)init NS_UNAVAILABLE;

/// 根据字典传递初始化
/// @param dic 字典
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
