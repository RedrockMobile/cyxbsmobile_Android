//
//  MessageSettingCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/21.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MessageSettingCellReuseIdentifier @"MessageSettingCell"

@class MessageSettingCell;

#pragma mark - MessageSettingCellDelegate

@protocol MessageSettingCellDelegate <NSObject>

@required

/// 滑动了某个cell的switch
/// @param cell 哪个cell
/// @param aSwitch 开关
- (void)messageSettingCell:(MessageSettingCell *)cell swipeSwitch:(UISwitch *)aSwitch;

@end

#pragma mark - MessageSettingCell

/// 消息设置的cell
@interface MessageSettingCell : UITableViewCell

/// 代理
@property (nonatomic, weak) id <MessageSettingCellDelegate> delegate;

/// 是否已打开，默认没打开
@property (nonatomic) BOOL switchOn;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 绘制文字和开关现状
/// @param title 文字
/// @param switchOn 是否打开，默认关闭
- (void)drawWithTitle:(NSString *)title switchOn:(BOOL)switchOn;

@end

NS_ASSUME_NONNULL_END
