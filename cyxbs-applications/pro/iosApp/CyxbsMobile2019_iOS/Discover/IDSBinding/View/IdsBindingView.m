//
//  IdsBindingView.m
//  CyxbsMobile2019_iOS
//
//  Created by 千千 on 2020/8/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "IdsBindingView.h"

@interface IdsBindingView()
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, weak) UIImageView *accountIcon;
@property (nonatomic, weak) UIImageView *passwdIcon;

@end

@implementation IdsBindingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //hintLabel
        self.hintLabel = [[UILabel alloc]init];
        self.hintLabel.text = @"若要查询，请输入您的统一认证码";
        if (@available(iOS 11.0, *)) {
            self.hintLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#EFEFF1" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [self addSubview:self.hintLabel];
        
        //account image view
        UIImageView *accountImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"账号"]];
        self.accountIcon = accountImageView;
        [self addSubview:accountImageView];
        
        //password image view
        UIImageView *passwdImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
        self.passwdIcon = passwdImageView;
        [self addSubview:passwdImageView];
        
        //account textfield
        UITextField *accountField = [[UITextField alloc]init];
        self.accountfield = accountField;
        accountField.placeholder = @"统一认证码";
        [accountField setTextColor:self.hintLabel.textColor];
        [self addSubview:accountField];
        
        //password textfield
        UITextField *passwdField = [[UITextField alloc]init];
        self.passTextfield = passwdField;
        [passwdField setTextColor:self.hintLabel.textColor];
        passwdField.placeholder = @"密码";
        [passwdField setSecureTextEntry:YES];
        [self addSubview:passwdField];
        
        //binding button
        UIButton *button = [[UIButton alloc]init];
        self.bindingButton = button;
        [self addSubview:button];
        [button.titleLabel setFont:[UIFont fontWithName:PingFangSCMedium size:18]];
        [button setTitle:@"确定绑定" forState:normal];
        button.layer.cornerRadius = 25;
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(touchIDSBindingButton) forControlEvents:UIControlEventTouchUpInside];
        if (@available(iOS 11.0, *)) {
            [button setBackgroundColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2921D1" alpha:1] darkColor:[UIColor colorWithHexString:@"#736CFF" alpha:1]]];
        } else {
            // Fallback on earlier versions
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self.mas_top).offset(86);
    }];
    [self.accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintLabel);
        make.top.equalTo(self.hintLabel.mas_bottom).offset(35);
        make.width.equalTo(@18.75);
        make.height.equalTo(@20.92);
    }];
    [self.passwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.height.equalTo(self.accountIcon);
        make.top.equalTo(self.accountIcon.mas_bottom).offset(47);
    }];
    [self.accountfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.accountIcon);
        make.left.equalTo(self.accountIcon.mas_right).offset(23);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@40);
    }];
    [self.passTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.accountfield);
        make.centerY.equalTo(self.passwdIcon);
    }];
    [self.bindingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passTextfield.mas_bottom).offset(72);
        make.centerY.equalTo(self);
        make.height.equalTo(@52);
        make.left.equalTo(self).offset(48);
        make.right.equalTo(self).offset(-48);
    }];
}

// MARK: delegate
-(void)touchIDSBindingButton {
    if([self.delegate respondsToSelector:@selector(touchBindingButton)]) {
        [self.delegate touchBindingButton];
    }
}

@end
