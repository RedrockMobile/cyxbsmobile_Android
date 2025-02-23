//
//  PMPBasicViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by Edioth Jin on 2021/9/14.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import <UIKit/UIKit.h>
// 有必要放在这里
#import "UIView+JHFrameExtension.h"
#import "UIScrollView+JHContentExtension.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 直接继承使用
 * 在控制器的 viewDidLoad 方法中写:
 self.view.backgroundColor = [UIColor colorNamed:@"xxx"];
 self.VCTitleStr = @"";
 self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
 */
@interface PMPBasicNavBarController : UIViewController

/// 设置这个属性自动完成顶部自定义导航条的设置
@property (nonatomic,copy)NSString *VCTitleStr;
/// 标题字体 Font， default is [UIFont fontWithName:PingFangSCSemibold size:21]
@property (nonatomic, strong) UIFont * titleFont;
/// 标题颜色，default is [UIColor colorWithHexString:@"FFFFFF"]
@property (nonatomic, strong) UIColor * titleColor;
/// 导航栏的颜色
@property (nonatomic, strong) UIColor * topBarBackgroundColor;
/// 返回按钮图片
@property (nonatomic, strong) UIImage * backBtnImage;

/// 顶部的bar
@property (nonatomic,strong) UIView * topBarView;
/// 控制器标题
@property (nonatomic,strong) UILabel * VCTitleLabel;
/// 返回按钮
@property (nonatomic,strong) UIButton * backBtn;

/// 整个导航栏的高度，包括状态栏和内容的高度
/// 状态栏是根据机型不同而变化
/// 内容高度固定为 44
- (CGFloat)getTopBarViewHeight;

/// 返回按钮的点击方法
- (void)backBtnClicked:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
