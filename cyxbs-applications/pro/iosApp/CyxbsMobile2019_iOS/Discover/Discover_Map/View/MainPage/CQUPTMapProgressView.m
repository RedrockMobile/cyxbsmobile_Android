//
//  CQUPTMapProgressView.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/24.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTMapProgressView.h"

@interface CQUPTMapProgressView ()

@property (nonatomic, weak) UIView *backgroundView;         // 底部的白色View

@end



@implementation CQUPTMapProgressView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title describe:(NSString *)describe
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        UIView *backgroundView = [[UIView alloc] init];
        if (@available(iOS 11.0, *)) {
            backgroundView.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#FFFFFF" alpha:1] darkColor:[UIColor colorWithHexString:@"#2D2D2D" alpha:1]];
        } else {
            backgroundView.backgroundColor = [UIColor whiteColor];
        }
        backgroundView.layer.cornerRadius = 8;
        [self addSubview:backgroundView];
        self.backgroundView = backgroundView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        if (@available(iOS 11.0, *)) {
            titleLabel.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15305C" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
        } else {
            titleLabel.textColor = [UIColor colorWithHexString:@"15305C"];
        }
        titleLabel.font = [UIFont fontWithName:PingFangSCSemibold size:18];
        [self.backgroundView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *describeLabel = [[UILabel alloc] init];
        describeLabel.text = describe;
        describeLabel.textColor = titleLabel.textColor;
        describeLabel.alpha = 0.9;
        describeLabel.font = [UIFont fontWithName:PingFangSCMedium size:16];
        [self.backgroundView addSubview:describeLabel];
        self.describeLabel = describeLabel;
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.tintColor = [UIColor colorWithHexString:@"#4B44E5"];
        progressView.backgroundColor = [UIColor colorWithHexString:@"#E7EFFD"];
        [self.backgroundView addSubview:progressView];
        self.progresView = progressView;
        
        UILabel *percentLabel = [[UILabel alloc] init];
        percentLabel.text = @"0%";
        percentLabel.textColor = titleLabel.textColor;
        percentLabel.alpha = 0.9;
        percentLabel.font = [UIFont fontWithName:PingFangSCMedium size:16];
        [self.backgroundView addSubview:percentLabel];
        self.percentLabel = percentLabel;
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self).offset(30);
//        make.trailing.equalTo(self).offset(-30);
        make.width.equalTo(@314);
        make.height.equalTo(@181);
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView).offset(20);
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.progresView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describeLabel.mas_bottom).offset(30);
        make.leading.equalTo(self.backgroundView).offset(37);
        make.trailing.equalTo(self.backgroundView).offset(-37);
        make.height.equalTo(@10);
    }];
    self.progresView.layer.cornerRadius = 5;
    self.progresView.clipsToBounds = YES;
    
    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.progresView.mas_bottom).offset(18);
    }];
}

@end
