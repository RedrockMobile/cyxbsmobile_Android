//
//  ElectricFeeModel.h
//  MoblieCQUPT_iOS
//
//  Created by 千千 on 2019/10/28.
//  Copyright © 2019 Orange-W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ElectricFeeItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface ElectricFeeModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) ElectricFeeItem *electricFeeItem;

/// 网络请求
- (void)requestSuccess:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
