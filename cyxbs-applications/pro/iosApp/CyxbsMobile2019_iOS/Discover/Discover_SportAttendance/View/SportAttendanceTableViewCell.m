//
//  SportAttendanceTableViewCell.m
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2022/8/3.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "SportAttendanceTableViewCell.h"
#import "Masonry.h"

@implementation SportAttendanceTableViewCell

//重写cell的方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背景
        self.contentView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF"] darkColor:[UIColor colorWithHexString:@"#2D2D2D"]];
        //设置圆角
        self.contentView.layer.cornerRadius = 8;
        //设置阴影
        self.contentView.layer.shadowOpacity = 0.5;
        self.contentView.layer.shadowRadius =  14;
        self.contentView.layer.shadowColor = [UIColor dm_colorWithLightColor: [UIColor colorWithHexString:@"#B5BCD1" alpha:0.2] darkColor: [UIColor colorWithHexString:@"#1D1D1D" alpha:0]].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
        }
    return self;
}

//设置两边间距及起始高度
- (void)setFrame:(CGRect)frame {
    frame.origin.y -= 13;
    frame.origin.x += 17;
    frame.size.width -= 2 * 17;
    [super setFrame:frame];
}

#pragma mark - Method
- (void)configUI {
    //打卡日期
    [self.contentView addSubview:self.dateLab];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.left.equalTo(self.contentView).offset(13);
    }];
    
    //时间图标
    UIImageView *timeImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"体育时间"]];
    [self.contentView addSubview:timeImgView];
    [timeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.dateLab.mas_bottom).offset(12);
        make.left.equalTo(self.dateLab);
    }];
    
    //打卡时间
    [self.contentView addSubview:self.timeLab];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImgView);
        make.left.equalTo(timeImgView.mas_right).offset(7);
    }];
    
    //地点图标
    UIImageView *spotImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"体育定位"]];
    [self.contentView addSubview:spotImgView];
    [spotImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLab);
        make.centerX.equalTo(self.contentView).offset(-27);
    }];
    
    //打卡地点
    [self.contentView addSubview:self.spotLab];
    [_spotLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLab);
        make.left.equalTo(spotImgView.mas_right).offset(7);
    }];
    
    //打卡类型
    [self.contentView addSubview:self.typeLab];
    [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLab);
        make.right.equalTo(self.contentView).offset(-11);
    }];
    
    //打卡图标
    UIImageView *typeImgView = [[UIImageView alloc] init];
    if ([self.typeLab.text isEqualToString:@"跑步"]) {
        typeImgView.image = [UIImage imageNamed:@"体育跑步"];
    }else{
        typeImgView.image = [UIImage imageNamed:@"体育其他"];
    }
    [self.contentView addSubview:typeImgView];
    [typeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLab);
        make.right.equalTo(self.typeLab.mas_left).offset(-7);
    }];
    
    //添加有效/无效
    if (_valid) {
        self.valiImgView.image = [UIImage imageNamed:@"体育有效"];
    }else{
        self.valiImgView.image = [UIImage imageNamed:@"体育无效"];
    }
    [self.contentView addSubview:self.valiImgView];
    [_valiImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dateLab);
        make.right.equalTo(self.contentView).offset(-11);
    }];

    //如果是奖励则添加奖励图标
    if (_is_award) {
        self.awardImgView.image = [UIImage imageNamed:@"体育奖励"];
        [self.contentView addSubview:self.awardImgView];
        [_awardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateLab);
            make.left.equalTo(self.dateLab.mas_right).offset(7);
        }];
    }
}

#pragma mark - Setter

//重写setter方法
- (void)setSa:(SportAttendanceItem *)sa{
    if (_sa != sa) {
        _sa = sa;
        self.dateLab.text = sa.date;
        self.timeLab.text = sa.time;
        if ([sa.spot isEqualToString:@"风雨操场（乒乓球馆）"] ||[sa.spot isEqualToString:@"风雨操场（篮球馆）"]) {
            self.spotLab.text = @"风雨操场";
        }else{
            self.spotLab.text = sa.spot;
        }
        self.typeLab.text = sa.type;
        self.valid = sa.valid;
        self.is_award = sa.is_award;
        [self configUI];
    }
}

#pragma mark - Getter

- (UILabel *)dateLab{
    if (!_dateLab) {
        _dateLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLab.font = [UIFont fontWithName:PingFangSCSemibold size:16];
        _dateLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B"] darkColor:[UIColor colorWithHexString:@"#F0F0F2"]];
    }
    return _dateLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _timeLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.8] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
    }
    return _timeLab;
}

- (UILabel *)spotLab{
    if (!_spotLab) {
        _spotLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _spotLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _spotLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.8] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
    }
    return _spotLab;
}

- (UILabel *)typeLab{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _typeLab.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2A4E84" alpha:0.8] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:0.4]];
    }
    return _typeLab;
}


- (UIImageView *)valiImgView{
    if (!_valiImgView) {
        _valiImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _valiImgView;
}

- (UIImageView *)awardImgView{
    if (!_awardImgView) {
        _awardImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _awardImgView;
}

@end
