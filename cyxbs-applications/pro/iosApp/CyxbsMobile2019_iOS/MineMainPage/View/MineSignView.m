//
//  SignView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/9/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "MineSignView.h"
//是否开启CCLog
#define CCLogEnable 1

@interface MineSignView ()
/// 显示已连续签到x天
@property (nonatomic, strong)UILabel *signDaysLabel;

@end

@implementation MineSignView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor =
        [UIColor dm_colorWithLightColor:RGBColor(255, 255, 255, 1) darkColor:RGBColor(57, 59, 64, 1)];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.9146666667*SCREEN_WIDTH);
            make.height.mas_equalTo(0.1546666667*SCREEN_WIDTH);
        }];
        
        self.layer.shadowOffset = CGSizeMake(11, 10);
        self.layer.shadowOpacity = 1;
        self.layer.shadowColor = [UIColor dm_colorWithLightColor:RGBColor(56, 79, 199, 0.07) darkColor:RGBColor(56, 79, 199, 0.05)].CGColor;
        self.layer.shadowRadius = 36;
        self.layer.cornerRadius = 8;
        [self addSignBtn];
        [self addSignDaysLabel];
    }
    return self;
}

- (void)addSignBtn {
    UIButton *btn = [[UIButton alloc] init];
    self.signBtn = btn;
    [self addSubview:btn];
    
    CGFloat height = 0.06933333333*SCREEN_WIDTH;
    CGFloat width = 0.128*SCREEN_WIDTH;
    btn.layer.cornerRadius = height/2;
    [btn setBackgroundColor:RGBColor(74, 68, 288, 1)];
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size:14];

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.744*SCREEN_WIDTH);
        make.top.equalTo(self).offset(0.04*SCREEN_WIDTH);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}

- (void)addSignDaysLabel {
    UILabel *label = [[UILabel alloc] init];
    self.signDaysLabel = label;
    [self addSubview:label];
    
    label.textColor = [UIColor dm_colorWithLightColor:RGBColor(21, 49, 91, 1) darkColor:KUIColorFromRGB(0xf0f0f2)];
    label.font = [UIFont fontWithName:PingFangSCMedium size:16];
    label.text = @"已连续签到x天";
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.04266666667*SCREEN_WIDTH);
        make.top.equalTo(self).offset(0.04266666667*SCREEN_WIDTH);
    }];
}

/// 设置签到天数
- (void)setSignDay:(NSString *)dayStr {
    //拦截空NSString*/空NSNumber*、非数字的字符串
    if (dayStr==nil || [dayStr integerValue]==0) {
        dayStr = @"0";
    }
    self.signDaysLabel.text = [NSString stringWithFormat:@"已连续签到%@天", dayStr];
}

/// 设置成是否可以签到
- (void)setSignBtnEnable:(BOOL)enable {
    if (enable) {
        [self.signBtn setBackgroundColor:RGBColor(74, 68, 288, 1)];
        self.signBtn.enabled = YES;
    }else {
        self.signBtn.backgroundColor = [UIColor dm_colorWithLightColor:KUIColorFromRGB(0xDDDDEA) darkColor:KUIColorFromRGB(0xAFAFAF)];
        self.signBtn.enabled = NO;
    }
    
}
@end
