//
//  PublishTextView.m
//  CyxbsMobile2019_iOS
//
//  Created by 宋开开 on 2023/3/17.
//  Copyright © 2023 Redrock. All rights reserved.
//

#import "PublishTextView.h"

@implementation PublishTextView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1.0];
        self.layer.cornerRadius = 8;
        [self addSubview:self.cancelBtn];
        [self addSubview:self.sureBtn];
        [self addSubview:self.publishTextView];
        [self.publishTextView addSubview:self.stringsLab];
        [self setPosition];
    }
    return self;
}

#pragma mark - Method

/// 设置控件位置
- (void)setPosition {
    // stringsLab
    [self.stringsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-32);
        make.bottom.equalTo(self).offset(-96);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    // cancelBtn
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(28);
        make.right.mas_equalTo(self.mas_centerX).offset(-14.5);
        make.bottom.equalTo(self).offset(-24);
        make.height.mas_equalTo(40);
    }];
    // sureBtn
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelBtn);
        make.size.mas_equalTo(self.cancelBtn);
        make.right.equalTo(self).offset(-28);
        make.left.mas_equalTo(self.mas_centerX).offset(14.5);
    }];
}


#pragma mark - Getter

- (UITextView *)publishTextView {
    if (_publishTextView == nil) {
        _publishTextView = [[UITextView alloc] init];
        _publishTextView.backgroundColor = [UIColor colorWithHexString:@"#E8F1FC" alpha:0.5];
        _publishTextView.layer.masksToBounds = YES;
        _publishTextView.layer.cornerRadius = 6;
        _publishTextView.font = [UIFont fontWithName:PingFangSCMedium size:16];
        _publishTextView.textColor = [UIColor colorWithHexString:@"#15315B" alpha:0.8];
        _publishTextView.textAlignment = NSTextAlignmentLeft;
        // 禁用滚动功能
        _publishTextView.scrollEnabled = NO;
    }
    return _publishTextView;
}

- (UILabel *)stringsLab {
    if (_stringsLab == nil) {
        _stringsLab = [[UILabel alloc] init];
        _stringsLab.textColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
        _stringsLab.font = [UIFont fontWithName:PingFangSCRegular size:12];
        _stringsLab.textAlignment = NSTextAlignmentCenter;
    }
    return _stringsLab;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor colorWithHexString:@"#EDF4FD" alpha:1.0];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = 20;
        _cancelBtn.titleLabel.text = @"取消";
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#9EA9BB" alpha:1.0] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:18];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn {
    if (_sureBtn == nil) {
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#C3D4EE" alpha:1.0];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 20;
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1.0] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size:18];
    }
    return _sureBtn;
}

@end
