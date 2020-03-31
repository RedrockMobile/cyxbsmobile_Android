//
//  EditMyInfoPresneter.h
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditMyInfoViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditMyInfoPresenter : NSObject

@property (nonatomic, strong) EditMyInfoViewController *attachedViwe;


/// 上传用户信息
/// @param userInfo 用户信息
- (void)uploadUserInfo:(NSDictionary *)userInfo
               success:(void (^)(NSDictionary *responseObject))success
               failure:(void (^)(NSError *error))failure;;

/// 上传用户头像
/// @param profile 头像
- (void)uploadProfile:(UIImage *)profile
              success:(void (^)(NSDictionary *responseObject))success
              failure:(void (^)(NSError *error))failure;

- (void)attachView: (EditMyInfoViewController *)view;
- (void)dettatchView;

@end

NS_ASSUME_NONNULL_END
