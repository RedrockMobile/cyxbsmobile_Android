//
//  AttitudeSelfPageModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 艾 on 2023/3/19.
//  Copyright © 2023 Redrock. All rights reserved.
//
/// 鉴权Model
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttitudeSelfPageModel : NSObject
- (void)requestAttitudePermissionWithSuccess:(void(^)(NSArray *array))success
                                     Failure:(void(^)(NSError * _Nonnull))failure;
@end

NS_ASSUME_NONNULL_END
