//
//  sendCodeView.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/11/3.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "sendCodeView.h"

@interface sendCodeView()

@property (nonatomic, strong) UILabel *barTitle;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *contactBtn;
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation sendCodeView

- (instancetype) initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        ///返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        _backBtn = backBtn;
        
        ///标题
        if (@available(iOS 11.0, *)) {
            UILabel *barTitle = [self creatLabelWithText:@"绑定邮箱" AndFont:[UIFont fontWithName:PingFangSCSemibold size: 21] AndTextColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]]];
            barTitle.textAlignment = NSTextAlignmentLeft;
            barTitle.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1.0];
            [self addSubview:barTitle];
            _barTitle = barTitle;
        } else {
            // Fallback on earlier versions
        }
        
        ///分割线
        UIView *line = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            line.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [self addSubview:line];
        _line = line;
        
        ///绑定邮箱描述 / 发送邮箱描述
        if (@available(iOS 11.0, *)) {
            UILabel *sendCodeLab = [self creatLabelWithText:@"" AndFont:[UIFont fontWithName:PingFangSCRegular size: 16] AndTextColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]]];
            sendCodeLab.numberOfLines = 0;
            sendCodeLab.textAlignment = NSTextAlignmentLeft;
            [self addSubview:sendCodeLab];
            _sendCodeLab = sendCodeLab;
        } else {
            // Fallback on earlier versions
        }
        
        ///输入框
        UITextField *codeField = [[UITextField alloc] init];
        codeField.font = [UIFont fontWithName:PingFangSCRegular size: 18];
        if (@available(iOS 11.0, *)) {
            codeField.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
            codeField.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#E8F0FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@" 请输入验证码" attributes:@{NSFontAttributeName: [UIFont fontWithName:PingFangSCMedium size:15], NSForegroundColorAttributeName:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.36] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.36]]}];
            codeField.attributedPlaceholder = string;
        } else {
            // Fallback on earlier versions
        }
        codeField.borderStyle = UITextBorderStyleNone;
        codeField.layer.cornerRadius = 8;
        UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(codeField.frame.origin.x,codeField.frame.origin.y,15.0, codeField.frame.size.height)];
        codeField.leftView = blankView;
        codeField.leftViewMode =UITextFieldViewModeAlways;
        codeField.clearButtonMode = UITextFieldViewModeNever;
        [self addSubview:codeField];
        _codeField = codeField;
        
        ///重新发送
        UILabel *resend = [[UILabel alloc] init];
        resend.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickedResend)];
        [resend addGestureRecognizer:tapRecognizer];
        if (IS_IPHONESE) {
            resend.font = [UIFont fontWithName:PingFangSCMedium size: 12];
        }else {
            resend.font = [UIFont fontWithName:PingFangSCMedium size: 15];
        }
        resend.backgroundColor = [UIColor clearColor];
        resend.textColor = [UIColor colorWithRed:75/255.0 green:69/255.0 blue:229/255.0 alpha:1.0];
        resend.textAlignment = NSTextAlignmentCenter;
        [self addSubview:resend];
        _resend = resend;
        
        ///失败按钮
        UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [contactBtn setTitle:@"验证失败？联系我们" forState:UIControlStateNormal];
        if (IS_IPHONESE) {
            contactBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 10];
        }else {
            contactBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 12];
        }
        [contactBtn setBackgroundColor:[UIColor clearColor]];
        [contactBtn setTitleColor:[UIColor colorWithRed:171/255.0 green:188/255.0 blue:216/255.0 alpha:1.0] forState:UIControlStateNormal];
        [contactBtn addTarget:self action:@selector(ClickedContactUS) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:contactBtn];
        _contactBtn = contactBtn;
        
        ///下一步按钮
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 18];
        [sureBtn setBackgroundColor:[UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0]];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(ClickedSure) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        _sureBtn = sureBtn;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.024 + SCREEN_WIDTH * 0.0453);
        make.height.mas_equalTo(SCREEN_HEIGHT * 0.0228 + SCREEN_HEIGHT * 0.0739);
    }];
    [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(SCREEN_HEIGHT * 0.0739, SCREEN_WIDTH * 0.0453, 0, 0)];
    
    [_barTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).mas_offset(SCREEN_HEIGHT * 0.069);
        make.left.mas_equalTo(_backBtn.mas_right).mas_offset(SCREEN_WIDTH * 0.0347);
        make.right.mas_equalTo(self.right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.2 * 25/75);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.barTitle.mas_bottom).mas_offset(5);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(3);
    }];

    [_sendCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0234);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0533);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.904);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.904 * 54/339);
    }];

    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sendCodeLab.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0074);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.0533);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.904);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.904 * 41/339);
    }];

    [_resend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeField.mas_top).mas_offset(SCREEN_HEIGHT * 0.0123);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.6827);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.2596);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.2596 * 21/88);
    }];

    [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeField.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0148);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.6507);
        make.right.mas_equalTo(self.right).mas_offset(-SCREEN_WIDTH * 0.048);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.3013 * 17/113);
    }];

    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.3867);
        make.left.mas_equalTo(self.left).mas_offset(SCREEN_WIDTH * 0.128);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.7467);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.7467 * 43/280);
    }];
    _sureBtn.layer.cornerRadius = _sureBtn.frame.size.height * 1/2;
}

#pragma mark - View的代理
- (void)backButtonClicked {
    if ([self.delegate respondsToSelector:@selector(backButtonClicked)]) {
        [self.delegate backButtonClicked];
    }
}

- (void)ClickedSure {
    if ([self.delegate respondsToSelector:@selector(ClickedSure)]) {
        [self.delegate ClickedSure];
    }
}

- (void)ClickedContactUS {
    if ([self.delegate respondsToSelector:@selector(ClickedContactUS)]) {
        [self.delegate ClickedContactUS];
    }
}

- (void)ClickedResend {
    if ([self.delegate respondsToSelector:@selector(ClickedResend)]) {
        [self.delegate ClickedResend];
    }
}


///创建提示文字
- (UILabel *)creatLabelWithText:(NSString *)text AndFont:(UIFont *)font AndTextColor:(UIColor *)color {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = font;
    lab.text = text;
    lab.textColor = color;
    return lab;
}



@end

