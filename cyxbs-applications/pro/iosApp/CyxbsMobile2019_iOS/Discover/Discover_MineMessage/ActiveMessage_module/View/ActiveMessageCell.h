//
//  ActiveMessageCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/20.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define ActiveMessageCellReuseIdentifier @"ActiveMessageCell"

#pragma mark - ActiveMessageCell

@interface ActiveMessageCell : UITableViewCell

/// 是否已读，注意，默认是yes，已读没有红点
@property (nonatomic) BOOL hadRead;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 计算高度（掉帧算法）
/// @param content 文字
/// @param width 宽度
+ (CGFloat)heightForContent:(NSString *)content
                   forWidth:(CGFloat)width;

/// 基础设置内容，头像和背景都有默认
/// @param title 标题
/// @param headUrl 头像urlStr
/// @param authorName 作者名字
/// @param date 日期
/// @param content 内容
/// @param imgUrl 内容的一张图片
- (CGSize)drawTitle:(NSString *)title
          headURL:(NSString *)headUrl
           author:(NSString *)authorName
             date:(NSString *)date
          content:(NSString *)content
        msgImgURL:(NSString *)imgUrl;

@end

NS_ASSUME_NONNULL_END
