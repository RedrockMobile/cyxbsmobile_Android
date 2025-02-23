//
//  safePopView.m
//  CyxbsMobile2019_iOS
//
//  Created by 阿栋 on 2020/10/30.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "safePopView.h"
#import <Masonry.h>

@interface safePopView()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *placeholderLab1;
@property (nonatomic, strong) UILabel *placeholderLab2;
@property (nonatomic, strong) UIButton *questionBtn;
@property (nonatomic, strong) UIButton *emailBtn;

@end

@implementation safePopView

- (instancetype) initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        UIView *backView = [[UIView alloc] init];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:15/255.0 blue:37/255.0 alpha:1.0];
        backView.alpha = 0.14;
        backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlertView)];
        [backView addGestureRecognizer:tap];
        [self addSubview:backView];
        _backView = backView;
        
        UIView *AlertView = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            AlertView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        AlertView.layer.cornerRadius = 16;
        [self addSubview:AlertView];
        _AlertView = AlertView;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"提醒绑定"];
        [_AlertView addSubview:imageView];
        _imageView = imageView;
        
        UILabel *placeholderLab1 = [[UILabel alloc] init];
        placeholderLab1.text = @"温馨提示";
        placeholderLab1.textAlignment = NSTextAlignmentCenter;
        placeholderLab1.font = [UIFont fontWithName:PingFangSCMedium size: 18];
        if (@available(iOS 11.0, *)) {
            placeholderLab1.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [_AlertView addSubview:placeholderLab1];
        _placeholderLab1 = placeholderLab1;
        
        UILabel *placeholderLab2 = [[UILabel alloc] init];
        placeholderLab2.text = @"为了您的账号安全，请设置密保/绑定邮箱";
        placeholderLab2.textAlignment = NSTextAlignmentCenter;
        placeholderLab2.font = [UIFont fontWithName:PingFangSCRegular size: 11];
        if (@available(iOS 11.0, *)) {
            placeholderLab2.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        [_AlertView addSubview:placeholderLab2];
        _placeholderLab2 = placeholderLab2;
        
        
        UIButton *questionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [questionBtn setTitle:@"设置密保" forState:UIControlStateNormal];
        [questionBtn setBackgroundColor:[UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1.0]];
        [questionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        questionBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 15];
        [questionBtn addTarget:self action:@selector(setQuestion) forControlEvents:UIControlEventTouchUpInside];
        [_AlertView addSubview:questionBtn];
        _questionBtn = questionBtn;
        
        
        UIButton *emailBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [emailBtn setTitle:@"绑定邮箱" forState:UIControlStateNormal];
        [emailBtn setBackgroundColor:[UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0]];
        [emailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        emailBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 15];
        [emailBtn addTarget:self action:@selector(setEmail) forControlEvents:UIControlEventTouchUpInside];
        [_AlertView addSubview:emailBtn];
        _emailBtn = emailBtn;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_AlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.3157);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.16);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.16);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.68 * 329/255);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_AlertView.mas_top).mas_offset(SCREEN_HEIGHT * 0.0493);
        make.left.mas_equalTo(_AlertView.mas_left).mas_offset(SCREEN_WIDTH * 0.168);
        make.right.mas_equalTo(_AlertView.mas_right).mas_offset(-SCREEN_WIDTH * 0.112);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.3882 * 108/150);
    }];
    
    [_placeholderLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageView.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0271);
        make.left.mas_equalTo(_AlertView.mas_left);
        make.right.mas_equalTo(_AlertView.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.2941 * 25/75);
    }];
    
    [_placeholderLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_placeholderLab1.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0123);
        make.left.mas_equalTo(_AlertView.mas_left);
        make.right.mas_equalTo(_AlertView.mas_right);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.8196 * 16/209);
    }];
    
    [_questionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_placeholderLab1.mas_bottom).mas_offset(SCREEN_HEIGHT * 0.0875);
        make.left.mas_equalTo(_AlertView.mas_left).mas_offset(SCREEN_WIDTH * 0.0613);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.256);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.256 * 34/96);
    }];
    _questionBtn.layer.cornerRadius = SCREEN_WIDTH * 0.256 * 34/96 * 1/2;
    
    [_emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_AlertView.mas_left).mas_offset(SCREEN_WIDTH * 0.3627);
        make.top.width.height.mas_equalTo(_questionBtn);
    }];
    _emailBtn.layer.cornerRadius = _questionBtn.layer.cornerRadius;
    
}

- (void) dismissAlertView {
    if ([self.delegate respondsToSelector:@selector(dismissAlertView)]) {
        [self.delegate dismissAlertView];
    }
}
- (void) setQuestion {
    if ([self.delegate respondsToSelector:@selector(setQuestion)]) {
        [self.delegate setQuestion];
    }
}
- (void) setEmail {
    if ([self.delegate respondsToSelector:@selector(setEmail)]) {
        [self.delegate setEmail];
    }
}

@end
