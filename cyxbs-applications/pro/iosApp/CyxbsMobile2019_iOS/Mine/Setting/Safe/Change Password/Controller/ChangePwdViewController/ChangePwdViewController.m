//
//  ChangePwdViewController.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/27.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "ResetPwdViewController.h"
#import "ByWordViewController.h"
#import "ByPasswordViewController.h"
#import <MBProgressHUD.h>
#import <Masonry.h>
#import "UserDefaultTool.h"

@interface ChangePwdViewController ()

@property (nonatomic, strong) UILabel *barTitle;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) MBProgressHUD *failureHud;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *popView;

@end

@implementation ChangePwdViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [self buildUI];
    
}

- (void)buildUI {
    
    ///返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backBtn setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    _backBtn = backBtn;
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.024 + SCREEN_WIDTH * 0.0453);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0228 + SCREEN_HEIGHT * 0.0739);
    }];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(SCREEN_HEIGHT * 0.0739, SCREEN_WIDTH * 0.0453, 0, 0)];
    
    ///标题
    UILabel *barTitle = [[UILabel alloc] init];
    barTitle.text = @"账号与安全";
    barTitle.font = [UIFont fontWithName:PingFangSCMedium size: 21];
    if (@available(iOS 11.0, *)) {
        barTitle.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    barTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:barTitle];
    _barTitle = barTitle;
    
    [_barTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top).mas_offset(SCREEN_HEIGHT * 0.069);
        make.left.mas_equalTo(_backBtn.mas_right).mas_offset(SCREEN_WIDTH * 0.0347);
        make.right.mas_equalTo(self.view.right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.2 * 25/75);
    }];
    
    ///分割线
    UIView *line = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        line.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:line];
    _line = line;
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.barTitle.mas_bottom).mas_offset(5);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(3);
    }];
    
    ///密码图片
    UIImageView *passwordImageView = [[UIImageView alloc] init];
    passwordImageView.image = [UIImage imageNamed:@"志愿账号"];
    [self.view addSubview:passwordImageView];
    _passwordImageView = passwordImageView;

    [_passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1232);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(SCREEN_WIDTH * 0.072);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.05);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0258);
    }];
    
    ///输入框横线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.2;
    [self.view addSubview:lineView];
    _lineView = lineView;

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1613);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(SCREEN_WIDTH * 0.08);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.848);
        make.height.equalTo(@1);
    }];

    ///输入框
    UITextField *passwordField = [[UITextField alloc] init];
    passwordField.font = [UIFont fontWithName:PingFangSCRegular size: 18];
    if (@available(iOS 11.0, *)) {
        passwordField.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请输入旧密码" attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSCMedium size:18], NSForegroundColorAttributeName:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.36] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.36]]}];
        passwordField.attributedPlaceholder = string;
    } else {
        // Fallback on earlier versions
    }
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [passwordField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passwordField];
    _passwordField = passwordField;

    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_barTitle.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.1195);
        make.left.mas_equalTo(_passwordImageView.mas_right).mas_offset(SCREEN_WIDTH * 0.0347);
        make.width.mas_equalTo(_lineView);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0309);
    }];
    
    ///忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setBackgroundColor:[UIColor clearColor]];
    forgetBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    if (IS_IPHONESE) {
        forgetBtn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size: 11];
    }else {
        forgetBtn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size: 13];
    }
    [forgetBtn setTintColor:[UIColor colorWithRed:171/255.0 green:188/255.0 blue:216/255.0 alpha:1.0]];
    [forgetBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    _forgetBtn = forgetBtn;
    
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0135);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(SCREEN_WIDTH * 0.7813);
        make.right.mas_equalTo(self.view.right).mas_offset(-SCREEN_WIDTH * 0.0453);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.1733 * 18/65);
    }];
    
    ///下一步按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateDisabled];
    nextBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 18];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [nextBtn setEnabled:NO];
    nextBtn.backgroundColor = [UIColor colorWithRed:194/255.0 green:203/255.0 blue:254/255.0 alpha:1.0];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    _nextBtn = nextBtn;
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(SCREEN_HEIGHT * 0.4815);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(SCREEN_WIDTH * 0.128);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.7467);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.7467 * 52/280);
    }];
    _nextBtn.layer.cornerRadius = SCREEN_WIDTH * 0.7467 * 52/280 * 1/2;
}

#pragma mark - 点击事件
///返回按钮
- (void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

///点击忘记密码（此处应该是跳转到杨远舟写的忘记密码界面）
- (void) forgetPwd {
    [self popFindPasswordView];
}

///弹出--->选择找回密码的方式
- (void) popFindPasswordView {
    ///蒙版
    UIView *backView = [[UIView alloc] init];
    backView.userInteractionEnabled = YES;
    backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:15/255.0 blue:37/255.0 alpha:1.0];
    backView.alpha = 0.14;
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:backView];
    _backView = backView;
    
    ///弹出页面
    UIView *popView = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        popView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    popView.layer.cornerRadius = 8;
    popView.userInteractionEnabled = YES;
    [self.view addSubview:popView];
    _popView = popView;
    
    [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender){
        [self->_popView removeFromSuperview];
        [self->_backView removeFromSuperview];
    }]];
    
    ///两个按钮
    UIButton *findByEmail = [UIButton buttonWithType:UIButtonTypeSystem];
    [findByEmail setBackgroundColor:[UIColor clearColor]];
    [findByEmail setTitle:@"邮箱找回" forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        findByEmail.titleLabel.tintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    findByEmail.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 18];
    findByEmail.layer.cornerRadius = 8;
    [findByEmail addTarget:self action:@selector(findByEmail) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:findByEmail];
    
    UIButton *findByQuestion = [UIButton buttonWithType:UIButtonTypeSystem];
    [findByQuestion setBackgroundColor:[UIColor clearColor]];
    [findByQuestion setTitle:@"密保找回" forState:UIControlStateNormal];
    if (@available(iOS 11.0, *)) {
        findByQuestion.titleLabel.tintColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        // Fallback on earlier versions
    }
    findByQuestion.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 18];
    findByQuestion.layer.cornerRadius = 8;
    [findByQuestion addTarget:self action:@selector(findByQuestion) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:findByQuestion];
    
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(SCREEN_HEIGHT * 0.3879);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(SCREEN_WIDTH * 0.16);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-SCREEN_WIDTH * 0.16);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.68 * 141/255);
    }];
    
    [findByEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(popView.mas_top);
        make.left.mas_equalTo(popView.mas_left);
        make.right.mas_equalTo(popView.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.68 * 141/255 * 1/2);
    }];
    
    [findByQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(findByEmail.mas_bottom);
        make.left.mas_equalTo(popView.mas_left);
        make.right.mas_equalTo(popView.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.68 * 141/255 * 1/2);
    }];
}

- (void)findByEmail {
    ByPasswordViewController *vc = [[ByPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [self dismissPopview];
}

- (void)findByQuestion {
    ByWordViewController *vc = [[ByWordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [self dismissPopview];
}

///找回密码弹窗消失
- (void) dismissPopview {
    [UIView animateWithDuration:0.5 animations:^{
        [self->_backView removeFromSuperview];
        [self->_popView removeFromSuperview];
    }];
}

///点击下一步，如果密码和缓存的一样，则跳转到下一个界面，否则弹窗提示失败
- (void) next {
    if ([self.passwordField.text isEqual:[UserDefaultTool getIdNum]]) {
        ResetPwdViewController *resetPwdVC = [[ResetPwdViewController alloc] init];
        [self.navigationController pushViewController:resetPwdVC animated:YES];
    }else {
        [self changePasswordFailure];
    }
}

///实时监听输入框长度
- (void)textFieldEditingChanged :(UITextField *)textField{
    _nextBtn.enabled = self.passwordField.text.length >= 6 ? YES : NO;
    _nextBtn.backgroundColor = self.passwordField.text.length >= 6 ? [UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0] : [UIColor colorWithRed:194/255.0 green:203/255.0 blue:254/255.0 alpha:1.0];
}

///弹窗：提示失败
- (void)changePasswordFailure{
    self.failureHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.failureHud.mode = MBProgressHUDModeText;
    self.failureHud.labelText = @"密码错误， 请重新输入";
    [self.failureHud hide:YES afterDelay:1.2];
    [self.failureHud setYOffset:-SCREEN_HEIGHT * 0.3704];
    [self.failureHud setColor:[UIColor colorWithRed:42/255.0 green:78/255.0 blue:132/255.0 alpha:1.0]];
}



@end
