//
//  ActiveMessageVC.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ActiveMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ActiveMessageVC;

#pragma mark - ActiveMessageVCDelegate

@protocol ActiveMessageVCDelegate <NSObject>

@required

/// 全部已读的回掉
/// @param vc 当前控制器
- (void)activeMessageVC_hadReadAllMsg:(ActiveMessageVC *)vc;

@end

/// 活动通知控制器
@interface ActiveMessageVC : UIViewController

/// 模型，要暴露
@property (nonatomic, strong) ActiveMessageModel *sysModel;

/// 代理
@property (nonatomic, weak) id delegate;

- (instancetype)init NS_UNAVAILABLE;

/// 根据模型和frame做，如果有模型直接上的那种，但网络请求后，需要手动加载sysModel
/// @param model 暴露的唯一模型
/// @param frame 视图大小
- (instancetype)initWithActiveMessage:(ActiveMessageModel *)model frame:(CGRect)frame;

/// 手动刷新，刷新所有可能的情况，多用于第一次网络请求
- (BOOL)hadReadAfterReloadData;

/// 全部标为已读，会触发一次代理
- (void)readAllMessage;

@end

NS_ASSUME_NONNULL_END
