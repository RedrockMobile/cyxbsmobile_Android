//
//  SystemMessageView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/18.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SystemMessageCell.h"

NS_ASSUME_NONNULL_BEGIN

@class SystemMessageView;

#pragma mark - SystemMessageViewDelegate

@protocol SystemMessageViewDelegate <UITableViewDataSource>

@required

/// 被选中了，执行跳转（其他的情况会自己处理），还会触发标为已读
/// @param view 当前tableView
/// @param index 单击了哪行
- (void)systemMessageTableView:(UITableView *)view didSelectedAtIndex:(NSInteger)index;

/// 视图将要删（应该给弹窗确认，yes将掉用删除）
/// @param view 当前tableView
/// @param set 选中的数组
/// @param needCancel 是否要东西
- (void)systemMessageTableView:(UITableView *)view willDeletePathWithIndexSet:(NSIndexSet *)set  showPresent:(void (^)(BOOL cancel))needCancel;

/// 应该要删哪些东西
/// @param view 当前tableView
/// @param set 删除的Ary，只有row有值
- (void)systemMessageTableView:(UITableView *)view mustDeletePathsWithIndexSet:(NSIndexSet *)set;

/// 触发标为已读，（需求没有说做已读弹窗）
/// @param view 当前View
/// @param index 被触发的下标
- (void)systemMessageTableView:(UITableView *)view hadReadForIndex:(NSInteger)index;

@end

#pragma mark - SystemMessageView

/// 系统消息页面
@interface SystemMessageView : UIView

/// 转发table的edit
@property (nonatomic) BOOL isEditing;

/// 代理
@property (nonatomic, weak) id <SystemMessageViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

/// 重新加载
- (void)reloadData;

/// 删除信息并确定要不要弹窗
/// @param set 信息集合
/// @param hadWarn 要不要弹窗
- (void)deleteMsgWithIndexSet:(NSIndexSet *)set withWarn:(BOOL)hadWarn;

@end

NS_ASSUME_NONNULL_END
