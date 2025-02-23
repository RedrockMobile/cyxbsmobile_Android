//
//  SystemMessageCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/18.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SystemMessageCellReuseIdentifier @"SystemMessageCell"

#pragma mark - SystemMessageCell

/// 系统消息的cell模式
@interface SystemMessageCell : UITableViewCell

/// 直接设置，就可以取消或添加红点，默认没有(没读有红点）
@property (nonatomic) BOOL hadRead;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 基础赋值控件文字
/// @param title 标题
/// @param content 简介
/// @param date 日期
- (void)drawWithTitle:(NSString *)title content:(NSString *)content date:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
