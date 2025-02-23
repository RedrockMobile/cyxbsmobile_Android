//
//  SportAttendanceHeadView.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/3.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SportAttendanceHeadView.h"

@interface SportAttendanceHeadView()

/// "总计"
@property (nonatomic, strong) UILabel *titelLab;

/// 已完成总计
@property (nonatomic, strong) UILabel *totDoneLab;

/// 未完成总计
@property (nonatomic, strong) UILabel *totNeedLab;

/// 已完成跑步
@property (nonatomic, strong) UILabel *runDoneLab;

/// 总跑步数
@property (nonatomic, strong) UILabel *runNeedLab;

/// 已完成其他
@property (nonatomic, strong) UILabel *othDoneLab;

/// 总其他数
@property (nonatomic, strong) UILabel *othNeedLab;

/// 奖励
@property (nonatomic, strong) UILabel *awaLab;

///图标
@property (nonatomic, strong) UIImageView *iconImgView;

@end

@implementation SportAttendanceHeadView

#pragma mark - Init

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        //背景渐变色
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = self.frame;
        //起点和终点表示的坐标系位置，（0，0)表示左上角，（1，1）表示右下角
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(1, 1);
        gl.colors = @[
            (__bridge id)[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#8CA3FD" alpha:0.2] darkColor:[UIColor colorWithHexString:@"#000000"]].CGColor,
            (__bridge id)[UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#D5F8FF" alpha:0.2] darkColor:[UIColor colorWithHexString:@"000000"]].CGColor
//            (__bridge id)[UIColor colorWithHexString:@"#D5F8FF" alpha:0.2].CGColor
        ];
        gl.locations = @[@(0),@(1.0f)];
        [self.layer addSublayer: gl];
        
        [self configUI];
    }
    return self;
}

#pragma mark - Getter
- (UILabel *)titelLab{
    if (!_titelLab) {
        _titelLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 90, 50, 25)];
        self.titelLab.text = @"总计:";
        _titelLab.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _titelLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#DFDFE3"]];
        
    }
    return _titelLab;
}

- (UILabel *)totDoneLab{
    if (!_totDoneLab) {
        _totDoneLab = [[UILabel alloc] init];
        _totDoneLab.font = [UIFont fontWithName:ImpactRegular size:48];
        _totDoneLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4A44E4"] darkColor:[UIColor colorWithHexString:@"#465FFF"]];
    }
    return _totDoneLab;
}

- (UILabel *)totNeedLab{
    if (!_totNeedLab) {
        _totNeedLab = [[UILabel alloc] init];
        _totNeedLab.font = [UIFont fontWithName:ImpactRegular size:36];
        _totNeedLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4A44E4"] darkColor:[UIColor colorWithHexString:@"#465FFF"]];
    }
    return _totNeedLab;
}

- (UILabel *)runDoneLab{
    if (!_runDoneLab) {
        _runDoneLab = [[UILabel alloc] init];
        _runDoneLab.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _runDoneLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#DFDFE3"]];
    }
    return _runDoneLab;
}

- (UILabel *)runNeedLab{
    if (!_runNeedLab) {
        _runNeedLab = [[UILabel alloc] init];
        _runNeedLab.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _runNeedLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.6] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:0.4]];
    }
    return _runNeedLab;
}

- (UILabel *)othDoneLab{
    if (!_othDoneLab) {
        _othDoneLab = [[UILabel alloc] init];
        _othDoneLab.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _othDoneLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#DFDFE3"]];
    }
    return _othDoneLab;
}

- (UILabel *)othNeedLab{
    if (!_othNeedLab) {
        _othNeedLab = [[UILabel alloc] init];
        _othNeedLab.font = [UIFont fontWithName:PingFangSCMedium size:12];
        _othNeedLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:0.6] darkColor:[UIColor colorWithHexString:@"#DFDFE3" alpha:0.4]];
    }
    return _othNeedLab;
}

- (UILabel *)awaLab{
    if (!_awaLab) {
        _awaLab = [[UILabel alloc] init];
        _awaLab.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _awaLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#DFDFE3"]];
    }
    return _awaLab;
}

- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"体育小飞鞋"]];
    }
    return _iconImgView;
}

#pragma mark - Setter

- (void)loadViewWithDate:(SportAttendanceModel *)sAData Isholiday:(bool)holiday{
    //数据正确且不在假期
    if (sAData.status == 10000 && holiday == false ) {
        self.totDoneLab.text = [NSString stringWithFormat:@"%ld ", sAData.run_done + sAData.other_done];
        self.totNeedLab.text = [NSString stringWithFormat:@"/%ld", sAData.run_total + sAData.other_total];
        self.runDoneLab.text = [NSString stringWithFormat:@"跑步：%ld", sAData.run_done];
        self.runNeedLab.text = [NSString stringWithFormat:@" /%ld", sAData.run_total];
        self.othDoneLab.text = [NSString stringWithFormat:@"其他：%ld", sAData.other_done];
        self.othNeedLab.text = [NSString stringWithFormat:@" /%ld", sAData.other_total];
        self.awaLab.text = [NSString stringWithFormat:@"奖励：%ld",sAData.award];
    }
}

#pragma mark - Method

- (void)configUI{
    self.totDoneLab.text = @"null";

    self.runDoneLab.text = @"跑步：null";

    self.othDoneLab.text = @"其他：null";
    
    self.awaLab.text = @"奖励:null";
    
    [self addSubview:self.titelLab];
    
    //总计
    [self addSubview:self.totDoneLab];
    [_totDoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titelLab.mas_bottom).offset(10);
        make.left.equalTo(self.titelLab.mas_right).offset(-10);
    }];
    
    [self addSubview:self.totNeedLab];
    [_totNeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.totDoneLab).offset(-2);
        make.left.equalTo(self.totDoneLab.mas_right);
    }];

    //跑步
    [self addSubview:self.runDoneLab];
    [_runDoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titelLab);
        make.top.equalTo(self.totDoneLab.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.runNeedLab];
    [_runNeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.runDoneLab.mas_right);
        make.bottom.equalTo(self.runDoneLab).offset(-1);
    }];
    
    //其他
    [self addSubview:self.othDoneLab];
    [_othDoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.runDoneLab);
    }];
    
    [self addSubview:self.othNeedLab];
    [_othNeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.othDoneLab.mas_right);
        make.bottom.equalTo(self.runDoneLab).offset(-1);
    }];

    //奖励
    [self addSubview:self.awaLab];
    [_awaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.runDoneLab);
    }];

    [self addSubview:self.iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.awaLab.mas_top);
        make.right.equalTo(self).offset(-12);
    }];
}

@end
