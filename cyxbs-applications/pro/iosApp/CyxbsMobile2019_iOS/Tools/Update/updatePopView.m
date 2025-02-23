//
//  updatePopView.m
//  CyxbsMobile2019_iOS
//
//  Created by Clutch Powers on 2022/3/22.
//  Copyright © 2022 Redrock. All rights reserved.
//

#import "updatePopView.h"
#import <Masonry.h>

@interface updatePopView ()

///图标
@property (nonatomic, strong) UIImageView *imageView;

///提示Label
@property (nonatomic, strong) UILabel *remindLbl;

///细节信息
@property (nonatomic, strong) UITextView *detailTextView;

///取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;

///更新按钮
@property (nonatomic, strong) UIButton *updateBtn;

///更新信息
@property (nonatomic, copy) NSDictionary *info;

@end

@implementation updatePopView

- (instancetype) initWithFrame:(CGRect)frame WithUpdateInfo:(NSDictionary *)info{
    if ([super initWithFrame:frame]) {
        self.info = info;
        
        [self addSubview:self.backView];
      
        [self addSubview:self.AlertView];
      
        [self.AlertView addSubview:self.imageView];
       
        [self.AlertView addSubview:self.remindLbl];
    
        [self.AlertView addSubview:self.detailTextView];
        
        [self.AlertView addSubview:self.cancelBtn];

        [self.AlertView addSubview:self.updateBtn];
      
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_AlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(SCREEN_HEIGHT * 0.2157);
        make.left.mas_equalTo(self.mas_left).mas_offset(SCREEN_WIDTH * 0.16);
        make.right.mas_equalTo(self.mas_right).mas_offset(-SCREEN_WIDTH * 0.16);
        make.height.mas_equalTo(300);
    }];
     
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_AlertView.mas_top);
        make.centerX.equalTo(self.mas_centerX);
        make.size.equalTo(@60);
    }];
    
    [_remindLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageView.mas_bottom);
        make.left.mas_equalTo(_AlertView.mas_left);
        make.right.mas_equalTo(_AlertView.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [_detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_remindLbl.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(_AlertView.mas_left).mas_offset(5);
            make.right.mas_equalTo(_AlertView.mas_right).mas_offset(-3);
            make.bottom.mas_equalTo(_AlertView.mas_bottom).mas_offset(-50);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.AlertView.mas_bottom).offset(-10);
        make.left.mas_equalTo(_AlertView.mas_left).mas_offset(SCREEN_WIDTH * 0.0613);
        make.width.mas_equalTo(SCREEN_WIDTH * 0.256);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.256 * 34/96);
    }];
    _cancelBtn.layer.cornerRadius = SCREEN_WIDTH * 0.256 * 34/96 * 1/2;
    
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_AlertView.mas_left).mas_offset(SCREEN_WIDTH * 0.3627);
        make.top.width.height.mas_equalTo(_cancelBtn);
    }];
    _updateBtn.layer.cornerRadius = _cancelBtn.layer.cornerRadius;
    
}

- (void) Cancel {
    if ([self.delegate respondsToSelector:@selector(Cancel)]) {
        [self.delegate Cancel];
    }
}
- (void) Update {
    if ([self.delegate respondsToSelector:@selector(Update)]) {
        [self.delegate Update];
    }
}

#pragma mark - getter

- (UIView *)backView{
    if (!_backView) {
        UIView *backView = [[UIView alloc] init];
        backView.userInteractionEnabled = YES;
        backView.backgroundColor = [UIColor colorWithRed:0/255.0 green:15/255.0 blue:37/255.0 alpha:1.0];
        backView.alpha = 0.3;
        backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _backView = backView;
    }
    return _backView;
}

- (UIView *)AlertView{
    if (!_AlertView) {
        UIView *AlertView = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            AlertView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        AlertView.layer.cornerRadius = 16;
        _AlertView = AlertView;
    }
    return _AlertView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"Cyxbs"];
        [_AlertView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)remindLbl{
    if (!_remindLbl) {
        UILabel *remindLbl = [[UILabel alloc] init];
        remindLbl.text = [NSString stringWithFormat:@"%@ 新版本已上线 ",self.info[@"version"]];
        remindLbl.textAlignment = NSTextAlignmentCenter;
        remindLbl.font = [UIFont fontWithName:PingFangSCMedium size: 17];
        if (@available(iOS 11.0, *)) {
            remindLbl.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            // Fallback on earlier versions
        }
        _remindLbl = remindLbl;
    }
    return _remindLbl;
}

- (UITextView *)detailTextView{
    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc]init];
        _detailTextView.editable = NO;
        _detailTextView.text =  [NSString stringWithFormat:@"%@ ",self.info[@"releaseNotes"]];
        _detailTextView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#000000" alpha:1]];
    }
    return _detailTextView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"暂时不用" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1.0]];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 15];
        [cancelBtn addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = cancelBtn;
    }
    return _cancelBtn;
}

- (UIButton *)updateBtn{
    if (!_updateBtn) {
        UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [updateBtn setBackgroundColor:[UIColor colorWithRed:72/255.0 green:65/255.0 blue:226/255.0 alpha:1.0]];
        [updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        updateBtn.titleLabel.font = [UIFont fontWithName:PingFangSCMedium size: 15];
        [updateBtn addTarget:self action:@selector(Update) forControlEvents:UIControlEventTouchUpInside];
        _updateBtn = updateBtn;
    }
    return _updateBtn;
}

@end
