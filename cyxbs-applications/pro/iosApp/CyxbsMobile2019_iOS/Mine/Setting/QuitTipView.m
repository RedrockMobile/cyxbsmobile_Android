//
//  QuitTipView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2020/12/16.
//  Copyright © 2020 Redrock. All rights reserved.
// 在设置页面点击 “退出登录按钮” 后弹出的弹窗就是这个类

#import "QuitTipView.h"
#import "掌上重邮-Swift.h"
@interface QuitTipView ()
/// 弹窗本体
@property(nonatomic,strong)UIView *tipView;

/// “退出登录” 按钮
@property(nonatomic,strong)UIButton *quitBtn;

/// 图标为“叉叉” 的取消按钮
@property(nonatomic,strong)UIButton *cancelBtn;

/// 显示@“退出登录” 的标题label
@property(nonatomic,strong)UILabel *titleLabel;

/// 显示@"是否退出当前账号"的字标题label
@property(nonatomic,strong)UILabel *subTitleLabel;
@end

@implementation QuitTipView
//MARK: - 重写的方法:
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:0.5];
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addTipView];
    }
    return self;
}

//MARK: - UI布局方法方法:
/// 添加 弹窗本体 的方法
- (void)addTipView{
    UIView *view = [[UIView alloc] init];
    self.tipView = view;
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.127*SCREEN_WIDTH);
        make.bottom.equalTo(self).offset(-0.334*SCREEN_HEIGHT);
        make.width.mas_equalTo(0.7533*SCREEN_WIDTH);
        make.height.mas_equalTo(0.4655*SCREEN_WIDTH);
    }];
    
    view.layer.cornerRadius = 12.5;
    
    if (@available(iOS 11.0, *)) {
        view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F8FB" alpha:1] darkColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:1]];
    } else {
        view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    
    [self addQuitBtn];
    [self addCancelBtn];
    [self addTitleLabel];
    [self addSubTitleLabel];
}

/// 添加@“退出登录”按钮
- (void)addQuitBtn{
    UIButton *btn = [[UIButton alloc] init];
    self.quitBtn = btn;
    [self.tipView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipView).offset(0.255*SCREEN_WIDTH);     //95.5pt
        make.bottom.equalTo(self.tipView).offset(-0.0613*SCREEN_WIDTH);  //23pt
        make.width.mas_equalTo(0.245*SCREEN_WIDTH);     //92pt
        make.height.mas_equalTo(0.095*SCREEN_WIDTH);    //35.5pt
    }];
    
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor colorWithHexString:@"#5655F2"];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:87/255.0 green:86/255.0 blue:242/255.0 alpha:1];
    }
    
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:PingFangSCSemibold size:15*fontSizeScaleRate_SE]];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.layer.cornerRadius = 0.0473*SCREEN_WIDTH;
    
    
    [btn addTarget:self action:@selector(quitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

///在tipView上添加titleLabel
- (void)addTitleLabel{
    UILabel *label = [[UILabel alloc] init];
    self.titleLabel = label;
    [self.tipView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tipView);
        make.top.equalTo(self.tipView).offset(0.0613*SCREEN_WIDTH); //23pt
    }];
    
    label.text = @"退出登录";
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    label.font = [UIFont fontWithName:PingFangSCSemibold size:18*fontSizeScaleRate_SE];
}

/// 添加 显示@"是否退出当前账号"的字标题label 的方法
- (void)addSubTitleLabel{
    UILabel *label = [[UILabel alloc] init];
    self.subTitleLabel = label;
    [self.tipView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tipView);
        make.top.equalTo(self.tipView).offset(0.184*SCREEN_WIDTH);
    }];
    
    label.text = @"是否退出当前账号";
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    label.font = [UIFont fontWithName:PingFangSCRegular size:13*fontSizeScaleRate_SE];

}

/// 添加 图标为“叉叉” 的取消按钮 的方法
- (void)addCancelBtn{
    UIButton *btn = [[UIButton alloc] init];
    self.cancelBtn = btn;
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tipView.mas_bottom).offset(0.0584*SCREEN_HEIGHT);
        make.width.height.mas_equalTo(0.058*SCREEN_HEIGHT);
    }];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"saveAskContent"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

//MARK: - 点击按钮后调用的方法:

/// 点击 退出登录按钮后调用的方法
- (void)quitBtnClicked{
    [SwiftToOC loginOut];
    [self.viewController.navigationController popViewControllerAnimated:NO];
}
/// 点击 图标为“叉叉” 的取消按钮 后调用的方法
- (void)cancelBtnClicked{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
