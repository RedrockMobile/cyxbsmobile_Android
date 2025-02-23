//
//  MineMessageTopView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/17.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SSRTopBarBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class MineMessageTopView;

#pragma mark - MineMessageTopViewDelegate

@protocol MineMessageTopViewDelegate <NSObject>

@required

/// 可定可以滑动到某个位置，重复点不会触发
/// @param view 顶部视图
/// @param firstBtn 从哪个btn开始滑动
/// @param secendbtn 去往哪个btn
- (void)mineMessageTopView:(MineMessageTopView *)view
            willScrollFrom:(UIButton *)firstBtn
                     toBtn:(UIButton *)secendbtn;

@end

#pragma mark - MineMessageTopView

/// 我的消息头视图
@interface MineMessageTopView : SSRTopBarBaseView

/// 代理
@property (nonatomic, weak) id <MineMessageTopViewDelegate> delegate;

/// 系统通知点
@property (nonatomic) BOOL systemHadMsg;

/// 活动通知点
@property (nonatomic) BOOL activeHadMsg;

/// 更多有没有设置
@property (nonatomic) BOOL moreHadSet;

/// 线是不是在动
@property (nonatomic, readonly) BOOL lineIsScroll;

/// 为“更多”添加事件
/// @param target 应该是个vc
/// @param action 应该弹出一个选择vc
- (void)addMoreBtnTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
