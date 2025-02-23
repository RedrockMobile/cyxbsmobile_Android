//
//  DLReminderView.m
//  CyxbsMobile2019_iOS
//
//  Created by 丁磊 on 2020/4/9.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "DLReminderView.h"

#define kRateX [UIScreen mainScreen].bounds.size.width/375   //以iPhoneX为基准
#define kRateY [UIScreen mainScreen].bounds.size.height/812  //以iPhoneX为基准
@implementation DLReminderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        } else {
            self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        }
        [self initBackButton];
        [self initTitleLabel];
        [self initNoticeLabel];
        [self initTextFiled];
        [self initNextButton];
    }
    return self;
}

- (void)initBackButton{
    self.backBtn = [[UIButton alloc]init];
    [self.backBtn setImage:[UIImage imageNamed:@"我的返回"] forState:UIControlStateNormal];
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    [self addSubview: self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(45*kRateY);
        make.left.equalTo(self.mas_left).mas_offset(14*kRateX);
        make.width.mas_equalTo(19);
        make.height.mas_equalTo(19);
    }];
}

/// @”为你的行程加标题“、@”为你的行程加具体内容“
- (void)initTitleLabel{
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.numberOfLines = 0;
    
    self.titleLab.font = [UIFont fontWithName:PingFangSCMedium size: 34];
    if (@available(iOS 11.0, *)) {
        self.titleLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#122D55" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        self.titleLab.textColor = [UIColor colorWithHexString:@"#122D55"];
    }
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).mas_offset(168*kRateY);
        make.left.equalTo(self.mas_left).mas_offset(18*kRateX);
    }];
}
/// 标题
- (void)initNoticeLabel{
    self.notoiceLab = [[UILabel alloc] init];
    self.notoiceLab.textAlignment = NSTextAlignmentLeft;
    self.notoiceLab.numberOfLines = 1;
    self.notoiceLab.font = [UIFont fontWithName:PingFangSCSemibold size: 15];
    if (@available(iOS 11.0, *)) {
        self.notoiceLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#122D55" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        self.notoiceLab.textColor = [UIColor colorWithHexString:@"#122D55"];
        // Fallback on earlier versions
    }
    [self addSubview:self.notoiceLab];
    [self.notoiceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLab.mas_top).mas_offset(-6*kRateY);
        make.left.equalTo(self.mas_left).mas_offset(18*kRateX);
    }];
}
- (void)initTextFiled{
    self.textFiled = [[DLTextFiled alloc] init];
    [self addSubview: self.textFiled];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).mas_offset(15*kRateY);
        make.left.equalTo(self.mas_left).offset(MAIN_SCREEN_W*0.0534);
        make.width.mas_equalTo(343*kRateX);
        make.height.mas_equalTo(55*kRateY);
    }];
}

- (void)initNextButton{
    self.nextBtn = [[DLNextButton alloc] initWithFrame:CGRectMake(77, 219, 33, 33)];
    [self addSubview: self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiled.mas_bottom).mas_offset(104*kRateY);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(66*kRateX);
        make.height.mas_equalTo(66*kRateX);
    }];
}
- (void)layoutSubviews{
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240*kRateX);
    }];
}

- (void)addBackGroundeCircle{
    UIView *topRight = [[UIView alloc] init];
    [self addSubview:topRight];
    
    topRight.layer.cornerRadius = 0.3414*MAIN_SCREEN_W;
    
    [topRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}
@end
