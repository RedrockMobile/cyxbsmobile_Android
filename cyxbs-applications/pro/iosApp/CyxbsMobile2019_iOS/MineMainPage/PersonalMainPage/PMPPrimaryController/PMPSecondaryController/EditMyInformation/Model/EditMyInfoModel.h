//
//  EditMyInfoModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditMyInfoModel : NSObject

+ (void)uploadProfile:(UIImage *)profile
              success:(void (^)(NSDictionary *responseObject))success
              failure:(void (^)(NSError *error))failure;

+ (void)uploadUserInfo:(NSDictionary *)userInfo
               success:(void (^)(NSDictionary *responseObject))success
               failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
