//
//  SignView.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 消息中心、邮票中心、意见与反馈 下面的现实签到天数、签到按钮的View
@interface MineSignView : UIView

/// 签到按钮
@property (nonatomic, strong)UIButton *signBtn;

/// 设置签到天数
- (void)setSignDay:(NSString*)dayStr;

/// 设置成是否可以签到
- (void)setSignBtnEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
