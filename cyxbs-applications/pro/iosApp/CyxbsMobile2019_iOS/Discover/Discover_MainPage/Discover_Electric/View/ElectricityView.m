//
//  ElectricityView.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/4/19.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "ElectricityView.h"
@interface ElectricityView ()

@end

@implementation ElectricityView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIDefaults];//对自身进行设置
        if ([UserItemTool defaultItem].building && [UserItemTool defaultItem].room) {
            [self addBindingView];
        } else {
            [self addNoBindingView];
        }
    }
    return self;
}

#pragma mark - Method
- (void)setUIDefaults {
    self.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F8F9FC" alpha:1] darkColor:[UIColor colorWithHexString:@"#1D1D1D" alpha:1]];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.16f;
    self.layer.shadowColor = [UIColor colorWithRed:174 / 255.0 green:182 / 255.0 blue:211 / 255.0 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.clipsToBounds = YES;
}

- (void)refreshViewIfNeeded {
    if ([UserItemTool defaultItem].building && [UserItemTool defaultItem].room) {
        [self addBindingView];
    } else {
        [self addNoBindingView];
    }
}

#pragma mark - 公共部分
- (void)addTitle {
    //左上角标题
    [self addSubview:self.electricFeeTitle];
}

#pragma mark - 未绑定部分
- (void)addNoBindingView {
    [self removeAllSubviews];
    [self addTitle];
    [self addHintLabel];
}

- (void)addHintLabel {
    [self addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(20);
    }];
}

#pragma mark - 绑定部分
- (void)addBindingView {
    [self removeAllSubviews];
    [self addTitle];
    //其中涉及网络请求的有time,money,consume
    [self addElectricFeeTime];
    [self addElectricFeeMoney];
    [self addElectricConsumption];
    [self addElectricFeeYuan];
    [self addElectricFeeDu];
    [self addElectricFeeHintLeft];
    [self addElectricFeeHintRight];
    [self configBindingUI];
}

- (void)addElectricFeeTime {
    //右上角抄表时间
    NSString *timeStr = [NSUserDefaults.standardUserDefaults objectForKey:@"ElectricFee_time"];
    NSString *elecTime = [[NSDate dateString:timeStr fromFormatter:NSDateFormatter.defaultFormatter withDateFormat:@"M.dd"] stringFromFormatter:NSDateFormatter.defaultFormatter withDateFormat:@"M月dd日抄表"];
    self.electricFeeTime.text = elecTime;

    [self addSubview:self.electricFeeTime];
}

- (void)addElectricFeeMoney {
    if ([NSUserDefaults.standardUserDefaults objectForKey:@"ElectricFee_money"] != NULL) {
        [self.electricFeeMoney setText:[NSUserDefaults.standardUserDefaults objectForKey:@"ElectricFee_money"]];
    } else {
        [self.electricFeeMoney setText:@"0"];
    }
    [self addSubview:self.electricFeeMoney];
}

- (void)addElectricConsumption {
    if ([NSUserDefaults.standardUserDefaults objectForKey:@"ElectricFee_degree"]) {
        self.electricConsumption.text = [NSString stringWithFormat:@"%@", [NSUserDefaults.standardUserDefaults objectForKey:@"ElectricFee_degree"]];
    } else {
        self.electricConsumption.text = @"0";
    }
    [self addSubview:self.electricConsumption];
}

- (void)addElectricFeeYuan {
    //汉字“元”
    [self addSubview:self.electricFeeYuan];
}

- (void)addElectricFeeDu {
    //汉字“度”
    [self addSubview:self.electricFeeDu];
}

- (void)addElectricFeeHintLeft {
    //汉字“费用、本月”
    [self addSubview:self.electricFeeHintLeft];
}

- (void)addElectricFeeHintRight {
    //汉字“使用度数，本月”
    [self addSubview:self.electricFeeHintRight];
}

- (void)configBindingUI {
    [self.electricFeeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.electricFeeTitle);
        make.right.equalTo(self).offset(-15);
    }];
    [self.electricFeeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeTitle.mas_bottom).offset(17);
        make.centerX.equalTo(self).offset(-self.width / 4.0);
        make.height.equalTo(@44);
    }];
    [self.electricConsumption mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeMoney);
        make.centerX.equalTo(self).offset(self.width / 4.0);
        make.height.equalTo(@44);
    }];
    [self.electricFeeYuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.electricFeeMoney.mas_right).offset(9);
        make.bottom.equalTo(self.electricFeeMoney).offset(-6);
    }];
    [self.electricFeeDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.electricConsumption.mas_right).offset(9);
        make.bottom.equalTo(self.electricConsumption).offset(-6);
    }];
    [self.electricFeeHintLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricFeeMoney.mas_bottom);
        make.centerX.equalTo(self.electricFeeMoney);
    }];
    [self.electricFeeHintRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.electricConsumption.mas_bottom);
        make.centerX.equalTo(self.electricConsumption);
    }];
}

#pragma mark - Lazy
- (UILabel *)electricFeeTime {
    if(!_electricFeeTime) {
        _electricFeeTime = [[UILabel alloc]init];
        _electricFeeTime.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _electricFeeTime.alpha = 0.54;
        _electricFeeTime.font = [UIFont fontWithName:PingFangSCLight size:10];
    }
    return _electricFeeTime;
}

- (UILabel *)electricFeeMoney {
    if (!_electricFeeMoney) {
        _electricFeeMoney = [[UILabel alloc]init];
        [_electricFeeMoney setTextColor:[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]]];
        [_electricFeeMoney setFont:[UIFont fontWithName:ImpactMedium size:36]];
    }
    return _electricFeeMoney;
}

- (UILabel *)electricConsumption {
    if (!_electricConsumption) {
        _electricConsumption = [[UILabel alloc]init];
        _electricConsumption.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:1] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:1]];
        _electricConsumption.font = [UIFont fontWithName:ImpactMedium size:36];
    }
    return _electricConsumption;
}

- (UILabel *)electricFeeYuan {
    if (!_electricFeeYuan) {
        _electricFeeYuan = [[UILabel alloc]init];
        _electricFeeYuan.text = @"元";
        _electricFeeYuan.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _electricFeeYuan.font = [UIFont fontWithName:PingFangSCMedium size:13];
    }
    return _electricFeeYuan;
}

- (UILabel *)electricFeeDu {
    if (!_electricFeeDu) {
        _electricFeeDu = [[UILabel alloc]init];
        _electricFeeDu.text = @"度";
        _electricFeeDu.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        _electricFeeDu.font = [UIFont fontWithName:PingFangSCMedium size:13];
    }
    return _electricFeeDu;
}

- (UILabel *)electricFeeTitle {
    if (!_electricFeeTitle) {
        _electricFeeTitle = [[UILabel alloc] initWithFrame:CGRectMake(14, 23, 80, 20)];
        _electricFeeTitle.text = @"电费查询";
        _electricFeeTitle.font = [UIFont fontWithName:PingFangSCSemibold size:18];
        _electricFeeTitle.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    }
    return _electricFeeTitle;
}

- (UILabel *)electricFeeHintLeft {
    if (!_electricFeeHintLeft) {
        _electricFeeHintLeft = [[UILabel alloc]init];
        _electricFeeHintLeft.text = @"费用/本月";
        _electricFeeHintLeft.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.6] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.6]];
        _electricFeeHintLeft.font = [UIFont fontWithName:PingFangSCMedium size:13];
    }
    return _electricFeeHintLeft;
}

- (UILabel *)hintLabel {
    if(!_hintLabel){
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = @"还未绑定账号哦～";
        _hintLabel.font = [UIFont fontWithName:PingFangSCLight size:15];
        _hintLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    }
    return _hintLabel;
}

- (UILabel *)electricFeeHintRight {
    if (!_electricFeeHintRight) {
        _electricFeeHintRight = [[UILabel alloc]init];
        _electricFeeHintRight.text = @"使用度数/本月";
        _electricFeeHintRight.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.6] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.6]];
        _electricFeeHintRight.font = [UIFont fontWithName:PingFangSCMedium size:13];
    }
    return _electricFeeHintRight;
}

@end
