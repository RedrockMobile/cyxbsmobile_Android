//
//  PublishMakeSureView.m
//  CyxbsMobile2019_iOS
//
//  Created by 宋开开 on 2023/3/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishMakeSureView.h"

@interface PublishMakeSureView ()

/// 标题
@property (nonatomic, strong) UILabel *titleLab;

/// 内容1 “自行负责“
@property (nonatomic, strong) UILabel *textLabAhead;

/// 内容2 “删除态度“
@property (nonatomic, strong) UILabel *textLabBehind;

@end

@implementation PublishMakeSureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1.0];
        self.layer.cornerRadius = 8;
        [self addSubview:self.titleLab];
        [self addSubview:self.textLabAhead];
        [self addSubview:self.textLabBehind];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.sureBtn];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

- (void)setPosition {
    // titleLab
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.centerX.mas_equalTo(self);
        make.left.equalTo(self).offset(21);
        make.height.mas_equalTo(40);
    }];
    // textLabAhead
    [self.textLabAhead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(15);
        make.height.mas_equalTo(17);
    }];
    // textLabBehind
    [self.textLabBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.top.equalTo(self.textLabAhead.mas_bottom).offset(10);
        make.height.mas_equalTo(34);
    }];
    // cancelBtn
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30.5);
        make.right.mas_equalTo(self.mas_centerX).offset(-15);
        make.bottom.equalTo(self).offset(-20.5);
        make.height.mas_equalTo(31);
    }];
    // sureBtn
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.cancelBtn);
        make.right.equalTo(self).offset(-30.5);
        make.left.mas_equalTo(self.mas_centerX).offset(15);
        make.bottom.equalTo(self.cancelBtn);
    }];
}

#pragma mark - Getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"是否确认发布该条“态度”，—旦发布后将不可更改!";
        _titleLab.textColor = [UIColor colorWithHexString:@"#15315B" alpha:1.0];
        _titleLab.font = [UIFont fontWithName:PingFangSCMedium size:14];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)textLabAhead {
    if (_textLabAhead == nil) {
        _textLabAhead = [[UILabel alloc] init];
        _textLabAhead.text = @"· 信息发布后，所有结果需自行负责";
        _textLabAhead.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.6];
        _textLabAhead.font = [UIFont fontWithName:PingFangSCRegular size:12];
        _textLabAhead.textAlignment = NSTextAlignmentLeft;
        _textLabAhead.numberOfLines = 0;
    }
    return _textLabAhead;
}

- (UILabel *)textLabBehind {
    if (_textLabBehind == nil) {
        _textLabBehind = [[UILabel alloc] init];
        _textLabBehind.text = @"· 如需删除“态度”，请联系红岩网校工作人员处理";
        _textLabBehind.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.6];
        _textLabBehind.font = [UIFont fontWithName:PingFangSCRegular size:12];
        _textLabBehind.textAlignment = NSTextAlignmentLeft;
        _textLabBehind.numberOfLines = 0;
    }
    return _textLabBehind;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#C3D4EE" alpha:1.0];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 15;
        _cancelBtn.titleLabel.text = @"我再想想";
        [_cancelBtn setTitle:@"我再想想" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1.0] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size:12];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#4A44E4" alpha:1.0];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 15;
        [_sureBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1.0] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont fontWithName:PingFangSCRegular size:12];
    }
    return _sureBtn;
}


@end
