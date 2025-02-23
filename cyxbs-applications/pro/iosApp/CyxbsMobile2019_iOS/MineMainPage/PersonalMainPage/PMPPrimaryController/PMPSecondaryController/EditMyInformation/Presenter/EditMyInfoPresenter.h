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

@property (nonatomic, strong) EditMyInfoViewController *attachedView;


/// 上传用户信息
/// @param userInfo 用户信息
- (void)uploadUserInfo:(NSDictionary *)userInfo Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/// 上传用户头像
/// @param profile 头像
- (void)uploadProfile:(UIImage *)profile Success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

- (void)attachView: (EditMyInfoViewController *)view;
- (void)dettatchView;

@end

NS_ASSUME_NONNULL_END
