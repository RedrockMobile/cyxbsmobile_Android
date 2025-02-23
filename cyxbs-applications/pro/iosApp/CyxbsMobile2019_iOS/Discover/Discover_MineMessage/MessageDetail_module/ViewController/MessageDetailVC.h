//
//  MessageDetailVC.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/30.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserPublishModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailVC : UIViewController

- (instancetype)init NS_UNAVAILABLE;

/// 根据URL加载页面
/// @param url 传入url
- (instancetype)initWithURL:(NSURL *)url;

/// 根据一堆奇奇怪怪的东西绘制
/// @param url 现在需要加载的url
/// @param useModel 不传入，则不增加顶部。传入时，无头像或无名字则只日期
/// @param moreURL 传入则跳转到第二层级URL
- (instancetype)initWithURL:(NSString *)url
            useSpecialModel:(nullable __kindof UserPublishModel * (^)(void))useModel
                    moreURL:(NSString  *_Nullable)moreURL;

@end

NS_ASSUME_NONNULL_END
