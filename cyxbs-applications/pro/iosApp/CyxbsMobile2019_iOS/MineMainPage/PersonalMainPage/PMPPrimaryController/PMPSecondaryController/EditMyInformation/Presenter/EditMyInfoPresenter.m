//
//  EditMyInfoPresneter.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2019/11/14.
//  Copyright © 2019 Redrock. All rights reserved.
//

#import "EditMyInfoPresenter.h"
#import "EditMyInfoModel.h"

@implementation EditMyInfoPresenter

- (void)uploadProfile:(UIImage *)profile Success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    
    [EditMyInfoModel uploadProfile:profile success:^(NSDictionary * _Nonnull responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            [UserItemTool defaultItem].headImgUrl = responseObject[@"data"][@"photosrc"];
            success();
        }
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

- (void)uploadUserInfo:(NSDictionary *)userInfo Success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    [UserItemTool defaultItem].nickname = userInfo[@"nickname"];
    [UserItemTool defaultItem].introduction = userInfo[@"introduction"];
    [UserItemTool defaultItem].qq = userInfo[@"qq"];
    [UserItemTool defaultItem].phone = userInfo[@"phone"];
//    [UserItemTool defaultItem].headImgUrl = userInfo[@"photo_src"];
    [UserItemTool defaultItem].gender = userInfo[@"gender"];
    [UserItemTool defaultItem].birthday = userInfo[@"birthday"];
    
    [EditMyInfoModel uploadUserInfo:userInfo success:^(NSDictionary * _Nonnull responseObject) {
        success();
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)attachView:(EditMyInfoViewController *)view {
    _attachedView = view;
}

- (void)dettatchView {
    _attachedView = nil;
}

@end
