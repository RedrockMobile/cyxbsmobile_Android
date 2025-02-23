//
//  TopBarBasicViewController.h
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/12/18.
//  Modified by Edioth on 2021/8/12
//  Copyright © 2020 Redrock. All rights reserved.
//
/**
 * 直接继承使用
 * 在控制器的 viewDidLoad 方法中写:
 * // 控制器视图的背景颜色，设置这个属性
 * self.view.backgroundColor = [UIColor colorNamed:@"242_243_248_1"];
 * // 标题文字
 * self.VCTitleStr = @"邮票明细";
 * // 修改标题的位置，设置这个属性
 * self.titlePosition = TopBarViewTitlePositionLeft;
 * // 修改分割线颜色，设置这个属性
 * self.splitLineColor = [UIColor colorNamed:@"42_78_132_0.1"];
 * // 修改标题的字体、大小，设置这个属性
 * self.titleFont = [UIFont fontWithName:PingFangSCSemibold size:22];
 * // 分割线的隐藏于否，设置这个属性
 * self.splitLineHidden = YES;
 */

#import <UIKit/UIKit.h>
#import "NothingStateView.h"

typedef NS_ENUM(NSInteger, TopBarViewTitlePosition) {
    TopBarViewTitlePositionCenter = 0,
    TopBarViewTitlePositionLeft = 1,
};

NS_ASSUME_NONNULL_BEGIN

/**
 * 带有一个顶部导航条的基类
 * 作为基类，所有的属性都有默认的设置，请调用 setter 方法修改
 * 在做布局的时候，最顶部的视图请对准导航栏的底部！！
 * 这很重要，否则会导致导航栏被覆盖或者导航栏遮挡住其他视图。
 * 如果有特殊需求，请在 子控制器的 viewDidLoad 方法中结束之前添加
 * [self.view bringSubviewToFront:self.topBarView];
 */
@interface TopBarBasicViewController : UIViewController

/// 导航栏的标题
/// 设置这个属性自动完成顶部自定义导航条的设置
@property (nonatomic,copy)NSString *VCTitleStr;
/// 顶部的bar
@property (nonatomic,strong)UIView *topBarView;
/// 是否隐藏分割线，default is NO
@property (nonatomic, assign, getter=isSplitLineHidden) BOOL splitLineHidden;
/// 标题字体 Font， default is [UIFont fontWithName:PingFangSCSemibold size:21]
@property (nonatomic, strong) UIFont * titleFont;
/// 标题颜色，default is Red:21 green:49 blue:91 alpha:1
@property (nonatomic, strong) UIColor * titleColor;
/// 导航栏的颜色 默认为和控制器 view 颜色一样
@property (nonatomic, strong) UIColor * topBarBackgroundColor;
/// 导航栏是否隐藏 默认为 NO
@property (nonatomic, assign, getter=isTopBarViewHidden) BOOL topBarViewHidden;
/// 导航栏标题的位置，default is TopBarViewTitlePositionCenter
@property (nonatomic, assign) TopBarViewTitlePosition titlePosition;
/// 分割线的颜色
@property (nonatomic, strong) UIColor * splitLineColor;
/// 返回按钮
@property (nonatomic,strong)UIButton *backBtn;

/// 整个导航栏的高度，包括状态栏和内容的高度
/// 状态栏是根据机型不同而变化
/// 内容高度固定为 44
- (CGFloat)getTopBarViewHeight;

/// 返回按钮的点击方法
- (void)backBtnClicked:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
