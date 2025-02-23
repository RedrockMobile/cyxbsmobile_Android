//
//  MessagePresentController.h
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2022/4/23.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MessagePresentController

/// 消息系统的弹窗样式（包含一个取消，一个确定，具体见效果 -- 待封装）
@interface MessagePresentController : UIViewController

/// 上面的也是最基本的，title和detail也可以选择其中一个，会自动布局
/// @param title 提示文字
/// @param titleColor 提示文字的颜色
- (void)addTitle:(NSString *)title textColor:(UIColor *)titleColor;

/// 添加一个detail（UI和title一样）
/// @param detail 提示文字
- (void)addDetail:(NSString *)detail;

/// dismiss时单击的是不是取消
/// @param touchCancel 单击后做的事情
- (void)addDismiss:(void (^)(BOOL cancel))touchCancel;
@end

NS_ASSUME_NONNULL_END
