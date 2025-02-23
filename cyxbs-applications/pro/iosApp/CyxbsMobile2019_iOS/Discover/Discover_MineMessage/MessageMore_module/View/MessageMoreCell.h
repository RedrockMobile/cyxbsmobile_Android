//
//  MessageMoreCell.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/19.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define MessageMoreCellReuseIdentifier @"MessageMoreCell"

#pragma mark - MessageMoreCell

/// 在消息系统中，一个Cell
@interface MessageMoreCell : UITableViewCell

/// 是否需要ball
@property (nonatomic) BOOL needBall;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/// 根据值绘制
/// @param img 图片应该是什么
/// @param title 文字是个啥
- (void)drawImg:(UIImage *)img title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
