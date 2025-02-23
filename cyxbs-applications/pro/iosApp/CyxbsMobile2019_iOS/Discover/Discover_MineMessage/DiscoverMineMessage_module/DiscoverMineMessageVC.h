//
//  DiscoverMineMessageVC.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

// 发现首页顶部中消息按钮的小VC
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MineMessageViewController

@interface DiscoverMineMessageVC : UIViewController

/// 是否需要小红点
@property (nonatomic) BOOL hadRead;

/// 刷新，会网络请求
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
