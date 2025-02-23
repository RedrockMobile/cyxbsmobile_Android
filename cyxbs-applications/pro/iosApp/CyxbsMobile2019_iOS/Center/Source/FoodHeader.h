//
//  FoodHeader.h
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/3/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

#ifndef FoodHeader_h
#define FoodHeader_h

#pragma mark - “美食”接口
#pragma mark - API

/// 美食主页数据
#define Center_GET_FoodHomePage_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-delicacy/HomePage"]

/// 刷新美食特征
#define Center_POST_FoodRefresh_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-delicacy/food/refresh"]

/// 随机美食数据
#define Center_POST_FoodResult_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-delicacy/food/result"]

/// 美食点赞
#define Center_POST_FoodPraise_API [CyxbsMobileBaseURL_1 stringByAppendingString:@"magipoke-delicacy/food/praise"]

#endif /* FoodHeader_h */
