//
//  SystemMessageVC.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SystemMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SystemMessageVC;

#pragma mark - SystemMessageVCDelegate

@protocol SystemMessageVCDelegate <NSObject>

@required

/// 没可读消息了，可以将相关圆点去掉
/// @param vc 系统消息控制器
- (void)systemMessageVC_hadReadAllMsg:(SystemMessageVC *)vc;

@end

#pragma mark - SystemMessageVC

/// 系统消息
@interface SystemMessageVC : UIViewController

/// 数据
@property (nonatomic, strong) SystemMsgModel *sysMsgModel;

/// 代理
@property (nonatomic, weak) id <SystemMessageVCDelegate> delegate;

/// 是否在编辑
@property (nonatomic) BOOL isEditing;

- (instancetype)init NS_UNAVAILABLE;

/// 根据模型传入，如果模型未加载，请手动reloadData
/// @param model 模型
- (instancetype)initWithSystemMessage:(SystemMsgModel *)model frame:(CGRect)frame;

/// 手动刷新，刷新所有可能的情况，多用于第一次网络请求
- (BOOL)hadReadAfterReloadData;

/// 全部标为已读，会触发一次代理
- (void)readAllMessage;

/// 删除所有信息
- (void)deleteAllReadMessage;

@end

NS_ASSUME_NONNULL_END
