//
//  MessagePresentView.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MessagePresentView

/// 真正被弹出的视图，可单独使用
@interface MessagePresentView : UIView

/// 添加一个标题信息，标题文字颜色可改
/// @param title 标题信息
/// @param titleColor 标题文字颜色
- (void)addTitleStr:(NSString *)title color:(UIColor *)titleColor;

/// 添加描述（UI和title一样）
/// @param detail 描述文字
- (void)addDetailStr:(NSString *)detail;

/// 单击了按钮，返回是不是取消
/// @param tapCancel 单击按钮，返回是否是取消
- (void)tapButton:(void (^)(BOOL isCancel))tapCancel;

@end

NS_ASSUME_NONNULL_END
